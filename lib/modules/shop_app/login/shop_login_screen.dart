import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_2/layout/shopApp/shop_layout.dart';
import 'package:flutter_application_2/modules/shop_app/login/cubit/cubit.dart';
import 'package:flutter_application_2/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_application_2/modules/shop_app/register/register_shop_screen.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/components/constants.dart';
import 'package:flutter_application_2/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status!) {
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data!.token);

              CacheHelper.saveData(
                      key: 'token', value: state.shopLoginModel.data!.token)
                  .then((value) {
                if (value) {
                  token = state.shopLoginModel.data!.token!;

                  //ShopCubit.get(context).getHomeData();
                  // ShopCubit.get(context).getCategoriesData();
                  // ShopCubit.get(context).getFavorites();
                  // ShopCubit.get(context).getProfile();

                  navigateAndFinish(context, ShopLayout());
                }
              }).catchError((error) {
                print(error.toString());
              });
              showToast(
                  msg: state.shopLoginModel.message!,
                  state: ToastStates.SUCCESS);
              //           Fluttertoast.showToast(
              //     msg: state.shopLoginModel.message!,
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.green,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );
            } else {
              print(state.shopLoginModel.message);

              showToast(
                  msg: state.shopLoginModel.message!, state: ToastStates.ERROR);
              //           Fluttertoast.showToast(
              //     msg: state.shopLoginModel.message!,
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 5,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0
              // );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFaild(
                          controller: emailController,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          onSubmitted: (value) {
                            print(value);
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          onTap: () {
                            print('enter your email address');
                          },
                          validated: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFaild(
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          validated: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is short';
                            }
                            return null;
                          },
                          onSubmitted: (value) {
                            print(value);
                            if (formKey.currentState!.validate()) {
                              print(emailController.text);
                              print(passwordController.text);
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          onChanged: (value) {
                            print(value);
                          },
                          isObscure: ShopLoginCubit.get(context).isPassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          onSuffix: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibillity();
                          },
                          onTap: () {
                            print('enter the password');
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildCondition(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  print(emailController.text);
                                  print(passwordController.text);
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login'),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterShopScreen());
                                },
                                text: 'register'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
