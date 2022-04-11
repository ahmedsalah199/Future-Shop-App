import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/search_cubit/search_state.dart';
import 'package:shop_app/shared/components/end_point.dart';

import '../../data/model/search_model.dart';
import '../../data/repository/repository.dart';
import '../../shared/components/constants.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit getCubit(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  getSearch({required String? text}) {
    emit(SearchLoadingState());
    Repository.postSearch(
      path: search,
      lang: "en",
      token: token,
      allData: {
        "text" : text
      }
    ).then((value) {
      searchModel = value;
      debugPrint('search  ${searchModel!.status}');
      emit(SearchSuccessState(searchModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SearchErrorState());
    });
  }

}
