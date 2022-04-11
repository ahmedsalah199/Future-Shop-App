import 'package:shop_app/data/model/register_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final SignUpModel registerModel ;

  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends RegisterState {}

class ChangeIconVisibility extends RegisterState {}
