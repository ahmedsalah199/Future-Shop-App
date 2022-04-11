import 'package:shop_app/data/model/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final LoginModel loginModel ;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState {}

class ChangeIconVisibility extends LoginState {}
