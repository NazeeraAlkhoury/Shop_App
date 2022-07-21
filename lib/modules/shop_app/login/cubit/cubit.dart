import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/shop_app/login_model.dart';
import 'package:flutter_application_2/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_application_2/shared/network/end_point.dart';
import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibillity() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordState());
  }

  late ShopLoginModel shopLoginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel));
      // print(shopLoginModel.message);
      // print(shopLoginModel.data!.token);
    }).catchError((error) {
      emit(ShopLoginErrorState(error));
      print(error.toString());
    });
  }
}
