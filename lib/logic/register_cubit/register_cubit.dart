import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/register_model.dart';
import 'package:shop_app/logic/register_cubit/register_state.dart';

import '../../data/repository/repository.dart';
import '../../shared/components/end_point.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit getCubit(context) => BlocProvider.of(context);

  SignUpModel? registerModel;

  void userRegister({required String name , required String email , required String password , required String phone ,}) {
    emit(RegisterLoadingState());
    Repository.postRegister(
      path: register,
      allData: {
        "name" : name ,
        "email" : email ,
        "password" : password ,
        "phone" : phone ,
      },
    ).then((value) {
      registerModel = value ;
      emit(RegisterSuccessState(registerModel!));
      debugPrint(registerModel!.status.toString());
    }).catchError((error) {
      emit(RegisterErrorState());
      debugPrint(error.toString());
    },
    );
  }

  IconData suffixIcon = Icons.remove_red_eye;

  bool obscureText = true;

  void changeIconVisibility() {
    suffixIcon = obscureText ? Icons.visibility_off : Icons.remove_red_eye;
    obscureText = !obscureText;
    emit(ChangeIconVisibility());
  }
}
