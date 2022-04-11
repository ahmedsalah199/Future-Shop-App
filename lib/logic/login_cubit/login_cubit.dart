import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/login_model.dart';
import 'package:shop_app/shared/components/end_point.dart';

import '../../data/repository/repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit getLoginCubit (context)=> BlocProvider.of(context);
  LoginModel? loginModel ;


  void userLogin ({required String email ,required String password }) {
    emit(LoginLoadingState());
    Repository.postLoginData(
        path: logIn,
        allData: {
      "email": email,
      "password": password,
    }).then((value){
      loginModel = value ;
      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      debugPrint(error.toString());
      emit(LoginErrorState());
    });

  }

  IconData suffixIcon = Icons.remove_red_eye ;
  bool obscureText = true ;
  void changeIconVisibility () {
    suffixIcon = obscureText ? Icons.visibility_off : Icons.remove_red_eye ;
    obscureText = !obscureText ;
    emit(ChangeIconVisibility());
  }

}
