import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/shared/cubit/states.dart';
import 'package:flutter_application_2/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);
  int current = 0;

  bool isBottomSheetShown = false;
  IconData iconFab = Icons.edit;

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
