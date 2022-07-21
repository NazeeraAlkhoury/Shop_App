import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/states.dart';

import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/components/constants.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateProfileSuccessState) {
          if (state.profileModel!.status!) {
            print(state.profileModel!.message);
            showToast(
                msg: state.profileModel!.message!, state: ToastStates.SUCCESS);
          }
          if (state.profileModel!.status! == false) {
            print(state.profileModel!.message);

            showToast(
                msg: state.profileModel!.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).profileModel;
        var cubit = ShopCubit.get(context);
        if (model != null) {
          nameController.text = model.data!.name!;
          emailController.text = model.data!.email!;
          phoneController.text = model.data!.phone!;
        }
        //  else {
        //   nameController.text = '';
        //   emailController.text = '';
        //   phoneController.text = '';
        // }
        return BuildCondition(
          condition: cubit.profileModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopUpdateProfileLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
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
                          return 'Email Address not be empty';
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
                      controller: phoneController,
                      label: 'Phone Number',
                      prefix: Icons.phone,
                      type: TextInputType.phone,
                      validated: (String? value) {
                        if (value!.isEmpty) {
                          return ' Phone Number not be empty';
                        }
                        return null;
                      },
                      onTap: () {
                        print('enter Phone');
                      },
                      onSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                          return null;
                        }
                      },
                      text: 'update',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'logout',
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
