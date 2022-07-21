import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';

import 'package:flutter_application_2/layout/shopApp/shop_layout.dart';
import 'package:flutter_application_2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_application_2/modules/shop_app/on_boarding/on_boarding_screen.dart';

import 'package:flutter_application_2/shared/bloc_observer.dart';
import 'package:flutter_application_2/shared/cubit/cubit.dart';
import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_application_2/shared/network/local/cache_helper.dart';
import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';
import 'package:flutter_application_2/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  //final bool? onBoarding;
  final Widget? startWidget;
  MyApp({this.isDark, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()
            ..getProfile(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: ThemeMode.light,
              // AppCubit.get(context).isDark
              //     ? ThemeMode.dark
              //     : ThemeMode.light,

              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              home: startWidget,
              //onBoarding != null ? ShopLoginScreen() : OnBoardingScreen(),
            );
          }),
    );
  }
}
