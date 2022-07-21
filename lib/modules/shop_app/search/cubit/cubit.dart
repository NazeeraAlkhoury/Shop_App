import 'package:bloc/bloc.dart';
import 'package:flutter_application_2/models/shop_app/search_model.dart';

import 'package:flutter_application_2/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_application_2/shared/network/end_point.dart';
import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void searchProduct(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text': text}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
