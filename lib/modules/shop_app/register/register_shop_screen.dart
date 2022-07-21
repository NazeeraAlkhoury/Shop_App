import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/shopApp/shop_layout.dart';

import 'package:flutter_application_2/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_application_2/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/components/constants.dart';
import 'package:flutter_application_2/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterShopScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopSuccessRegisterState) {
              if (state.registerUser!.status!) {
                CacheHelper.saveData(
                  key: 'token',
                  value: state.registerUser!.data!.token,
                ).then((value) {
                  if (value) {
                    token = state.registerUser!.data!.token!;
                    // ShopCubit.get(context).getHomeData();
                    // ShopCubit.get(context).getCategoriesData();
                    // ShopCubit.get(context).getFavorites();
                    // ShopCubit.get(context).getProfile();
                    navigateAndFinish(context, ShopLayout());
                  }
                }).catchError((error) {
                  print(error.toString());
                });
                showToast(
                    msg: state.registerUser!.message!,
                    state: ToastStates.SUCCESS);
              }
              if (state.registerUser!.status == false) {
                showToast(
                    msg: state.registerUser!.message!,
                    state: ToastStates.ERROR);
              }
            }
          },
          builder: (context, state) {
            var cubit = ShopRegisterCubit.get(context);

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
                            'REGISTER',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormFaild(
                            controller: nameController,
                            label: 'User Name',
                            prefix: Icons.person,
                            type: TextInputType.name,
                            validated: (String? value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            onTap: () {
                              print('enter name');
                            },
                            onSubmitted: (value) {
                              print(value);
                            },
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFaild(
                            controller: emailController,
                            label: 'Email Address',
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                            validated: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email Address must not be empty';
                              }
                              return null;
                            },
                            onTap: () {
                              print('enter Email');
                            },
                            onSubmitted: (value) {
                              print(value);
                            },
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFaild(
                            controller: passwordController,
                            label: 'Passsword',
                            prefix: Icons.lock_outline,
                            isObscure: cubit.isPassword,
                            suffix: cubit.suffix,
                            onSuffix: () {
                              cubit.changePassword();
                            },
                            type: TextInputType.visiblePassword,
                            validated: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is short';
                              }
                              return null;
                            },
                            onTap: () {
                              print('enter Password');
                            },
                            onSubmitted: (value) {
                              print(value);
                            },
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFaild(
                            controller: phoneController,
                            label: 'Phone Number',
                            prefix: Icons.phone,
                            type: TextInputType.phone,
                            validated: (String? value) {
                              if (value!.isEmpty) {
                                return ' Phone Number must not be empty';
                              }
                              return null;
                            },
                            onTap: () {
                              print('enter Phone');
                            },
                            onSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                print(passwordController.text);
                                cubit.registerUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                              return null;
                            },
                            onChanged: (value) {
                              print(value);
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          BuildCondition(
                            condition: state is! ShopLoadingRegisterState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    print(passwordController.text);
                                    cubit.registerUser(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                  return null;
                                },
                                text: 'register'),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
