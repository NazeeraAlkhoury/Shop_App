import 'package:flutter_application_2/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterChangePasswordState extends ShopRegisterStates {}

class ShopLoadingRegisterState extends ShopRegisterStates {}

class ShopSuccessRegisterState extends ShopRegisterStates {
  final ShopLoginModel? registerUser;
  ShopSuccessRegisterState(this.registerUser);
}

class ShopErrorRegisterState extends ShopRegisterStates {}
