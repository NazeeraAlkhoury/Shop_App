import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/states.dart';
import 'package:flutter_application_2/shared/components/components.dart';
//import 'package:flutter_application_2/models/shop_app/favorites_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (state.changeFavoritesModel!.status!) {
            showToast(
                msg: state.changeFavoritesModel!.message!,
                state: ToastStates.SUCCESS);
          }
          if (!state.changeFavoritesModel!.status!) {
            showToast(
                msg: state.changeFavoritesModel!.message!,
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: BuildCondition(
            condition: cubit.favoritesMD != null,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListItem(
                  cubit.favoritesMD!.data!.data[index].product, context),
              separatorBuilder: (context, index) => Divider(),
              itemCount: cubit.favoritesMD!.data!.data.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
