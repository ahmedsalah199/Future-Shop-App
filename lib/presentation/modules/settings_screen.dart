import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/logic/shop_cubit/shop_cubit.dart';
import 'package:shop_app/logic/shop_cubit/shop_state.dart';
import 'package:shop_app/presentation/modules/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(state is ShopSuccessUpdateProfileState){
            Fluttertoast.showToast(
              msg: state.updateProfileModel.message.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20.0,
            );
        }
      },
      builder: (context, state) {
        var profile = ShopCubit.get(context).profileModel;
        var cubit = ShopCubit.get(context);
        nameController.text = ShopCubit.get(context).profileModel != null
            ? profile!.data!.name!
            : "";
        emailController.text = ShopCubit.get(context).profileModel != null
            ? profile!.data!.email!
            : "";
        phoneController.text = ShopCubit.get(context).profileModel != null
            ? profile!.data!.phone!
            : "";

        if (profile != null) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: keyForm,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextForm(
                      controller: nameController,
                      keyboardType: cubit.keyBoardName,
                      readOnly: cubit.readOnly,
                      label: 'Name',
                      prefixIcon: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
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
                      keyboardType: cubit.keyBoardEmail,
                      label: 'Email',
                      readOnly: cubit.readOnly,
                      prefixIcon: Icons.email,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email Can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextForm(
                      controller: phoneController,
                      keyboardType: cubit.keyBoardPhone,
                      readOnly: cubit.readOnly,
                      label: 'Phone',
                      prefixIcon: Icons.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextForm(
                      controller: passwordController,
                      keyboardType: cubit.keyBoardPassword,
                      label: "Password",
                      readOnly: cubit.readOnly,
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
                    cubit.isUpDate == true
                        ? Row(
                            children: [
                              Expanded(
                                child: defaultButton(
                                    text: 'Cancel',
                                    function: () {
                                      cubit.updateIconSettings();
                                    },
                                    background: Colors.white,
                                    colorText: Colors.black),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: defaultButton(
                                      text: 'Save',
                                      function: () {
                                        if(keyForm.currentState!.validate()) {
                                          cubit.updateProfile(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                          );
                                          if (state is !ShopLoadingUpdateProfileState) {
                                            cubit.updateIconSettings();
                                          }
                                        }

                                      })),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: defaultButton(
                                    text: 'LOGOUT',
                                    function: () {
                                      SharedPreferencesData.removeData(
                                              key: 'token')
                                          .then((value) {
                                        ShopCubit.get(context).currentIndex = 0;
                                        navigatorTo(
                                            screen: const LoginScreen(),
                                            context: context);
                                      });
                                    },
                                    background: Colors.white,
                                    colorText: Colors.black),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: defaultButton(
                                  text: 'Update',
                                  function: () {
                                    cubit.updateIconSettings();
                                  },
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
