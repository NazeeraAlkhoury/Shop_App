import 'package:flutter_application_2/models/shop_app/change_favorites_model.dart';
import 'package:flutter_application_2/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialstate extends ShopStates {}

class ShopChangeNavBarstate extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopSuccessState extends ShopStates {}

class ShopErrorState extends ShopStates {
  final String error;
  ShopErrorState(this.error);
}

//class ShopGetCategoriesLoadingState extends ShopStates {}

class ShopGetCategoriesSuccessState extends ShopStates {}

class ShopGetCategoriesErrorState extends ShopStates {
  final String error;
  ShopGetCategoriesErrorState(this.error);
}

class ShopSuccessChangeFavState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangefavoritesModel? changeFavoritesModel;
  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {
  final String error;
  ShopErrorGetFavoritesState(this.error);
}

class ShopGetProfileLoadingState extends ShopStates {}

class ShopGetProfileSuccessState extends ShopStates {
  final ShopLoginModel? profileModel;
  ShopGetProfileSuccessState(this.profileModel);
}

class ShopGetProfileErrorState extends ShopStates {
  final String error;
  ShopGetProfileErrorState(this.error);
}

class ShopUpdateProfileLoadingState extends ShopStates {}

class ShopUpdateProfileSuccessState extends ShopStates {
  final ShopLoginModel? profileModel;
  ShopUpdateProfileSuccessState(this.profileModel);
}

class ShopUpdateProfileErrorState extends ShopStates {
  final String error;
  ShopUpdateProfileErrorState(this.error);
}

// class SearchLoadingState extends ShopStates {}

// class SearchSuccessState extends ShopStates {}

// class SearchErrorState extends ShopStates {}
