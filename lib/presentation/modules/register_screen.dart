import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/logic/register_cubit/register_cubit.dart';
import 'package:shop_app/logic/register_cubit/register_state.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/shared_preferences.dart';

import '../../logic/shop_cubit/shop_cubit.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var registerFormKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                if (state.registerModel.status == true) {
                  SharedPreferencesData.saveData(
                      key: 'token', value: state.registerModel.data!.token).then((value){
                        token = state.registerModel.data!.token! ;
                        ShopCubit.get(context).getProfile();
                  });
                  Fluttertoast.showToast(
                    msg: state.registerModel.message.toString(),
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
                    msg: state.registerModel.message.toString(),
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
          var cubit = RegisterCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: registerFormKey,
                    child: Column(
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Column(
                          children: [
                            defaultTextForm(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              label: "Name",
                              prefixIcon: Icons.add,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name Can\'t be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextForm(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: "Email",
                              prefixIcon: Icons.email_outlined,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email Can\'t be empty';
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
                                  return 'Password Can\'t be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            defaultTextForm(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              label: "Phone",
                              prefixIcon: Icons.phone,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone Can\'t be empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            state is RegisterLoadingState
                                ? const Center(
                                child: CircularProgressIndicator())
                                : defaultButton(
                                text: 'REGISTER',
                                function: () {
                                  if (registerFormKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text
                                    );
                                  }
                                }
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account ? ',
                                style: TextStyle(color: Colors.grey)),
                            TextButton(
                              onPressed: () {
                                navigatorTo(
                                    screen: RegisterScreen(),
                                    context: context);
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
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
