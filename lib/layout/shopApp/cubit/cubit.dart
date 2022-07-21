import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/states.dart';
import 'package:flutter_application_2/models/shop_app/categories_model.dart';
import 'package:flutter_application_2/models/shop_app/change_favorites_model.dart';
import 'package:flutter_application_2/models/shop_app/favorites_model.dart';

import 'package:flutter_application_2/models/shop_app/home_model.dart';
import 'package:flutter_application_2/models/shop_app/login_model.dart';

import 'package:flutter_application_2/modules/shop_app/categories/categories_screen.dart';
import 'package:flutter_application_2/modules/shop_app/favorites/favorites_screen.dart';
import 'package:flutter_application_2/modules/shop_app/products/products_screen.dart';
import 'package:flutter_application_2/modules/shop_app/setting/setting_screen.dart';
import 'package:flutter_application_2/shared/components/constants.dart';
import 'package:flutter_application_2/shared/network/end_point.dart';
import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialstate());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    //if (index == 3) getProfile();
    emit(ShopChangeNavBarstate());
  }

  List<Widget> screen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  Map<int, bool> favorites = {};

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel.toString());
      // printFullText(homeModel!.data!.banners[0].image.toString());

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    //emit(ShopGetCategoriesLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      printFullText(categoriesModel.toString());
      emit(ShopGetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoriesErrorState(error));
    });
  }

  ChangefavoritesModel? changeFavoritesModel;

  void changeFavorites({
    required int productId,
  }) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopSuccessChangeFavState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangefavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      }
      getFavorites();
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());

      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesMD;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesMD = FavoritesModel.fromJson(value.data);
      printFullText(favoritesMD.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState(error));
    });
  }

  ShopLoginModel? profileModel;
  void getProfile() {
    emit(ShopGetProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ShopGetProfileSuccessState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileErrorState(error));
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateProfileLoadingState());
    DioHelper.updateData(
      url: UPDATE_PROFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((value) {
      profileModel = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateProfileSuccessState(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileErrorState(error));
    });
  }

  // SearchModel? searchModel;

  // void searchProduct(String text) {
  //   emit(SearchLoadingState());
  //   DioHelper.postData(url: SEARCH, data: {'text': text}).then((value) {
  //     searchModel = SearchModel.fromJson(value.data);
  //     emit(SearchSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SearchErrorState());
  //   });
  // }
}
