
import 'package:shop_app/data/model/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}
class SearchSuccessState extends SearchState {
  final SearchModel searchModel ;

  SearchSuccessState(this.searchModel);
}
class SearchErrorState extends SearchState {}


