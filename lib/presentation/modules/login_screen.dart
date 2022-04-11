import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/logic/login_cubit/login_cubit.dart';
import 'package:shop_app/logic/login_cubit/login_state.dart';
import 'package:shop_app/presentation/modules/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/shared_preferences.dart';

import '../../logic/shop_cubit/shop_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              SharedPreferencesData.saveData(key: 'token', value: state.loginModel.data!.token).then((
                  value) {
                token = state.loginModel.data!.token! ;
                ShopCubit.get(context).getProfile();
              }
              );
              Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20.0,
              );
              navigatorTo(screen: const HomeScreen(), context: context);
            } else {
              Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 20.0,
              );
            }
          }
        }, builder: (context, state) {
          var cubit = LoginCubit.getLoginCubit(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: Column(
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 43,
                        ),
                        Column(
                          children: [
                            defaultTextForm(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: "Email",
                              prefixIcon: Icons.email_outlined,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return " Please Enter Your Email Address";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextForm(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              label: "Password",
                              obscureText: cubit.obscureText,
                              suffixIcon: cubit.suffixIcon,
                              suffixPressed: () {
                                cubit.changeIconVisibility();
                              },
                              prefixIcon: Icons.lock_outlined,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return " Please Enter Your Password ";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            state is LoginLoadingState
                                ? const Center(
                                child: CircularProgressIndicator())
                                : defaultButton(
                              text: 'LOGIN',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);

                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                         Padding(
                          padding:  const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account ? ',
                                  style: TextStyle(color: Colors.grey)),
                              TextButton(
                                onPressed: () {
                                  navigatorTo(
                                      screen:  const RegisterScreen(), context: context);
                                },
                                child: const Text(
                                  'REGISTER',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
