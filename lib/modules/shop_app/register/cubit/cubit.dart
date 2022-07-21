import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/shop_app/login_model.dart';
import 'package:flutter_application_2/modules/shop_app/register/cubit/states.dart';

import 'package:flutter_application_2/shared/network/end_point.dart';
import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordState());
  }

  ShopLoginModel? registerModel;
  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopLoadingRegisterState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      print(registerModel!.status);
      emit(ShopSuccessRegisterState(registerModel));
    }).catchError((error) {
      emit(ShopErrorRegisterState());
      print(error.toString());
    });
  }
}
