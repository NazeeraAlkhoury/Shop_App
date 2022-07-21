import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/network/local/cache_helper.dart';

String token = CacheHelper.getData(key: 'token');

void signOut(context) => CacheHelper.removeData(value: 'token').then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
        ShopCubit.get(context).currentIndex = 0;
      }
    });

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}
