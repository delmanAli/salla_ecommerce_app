import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/states.dart';
import 'package:sala_shop_app/shared/components/constant.dart';
import 'package:sala_shop_app/shared/components/default_buttom.dart';
import 'package:sala_shop_app/shared/components/default_form_field.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = 'settingScreen';
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var model = ShopCubit.get(context).userModal;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        // print(model.data.name);
        // print(model.data.email);
        // print(model.data.phone);

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModal != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKeys,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserProfileState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: 'Enter A Name',
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: 'Enter A Email',
                    label: 'Email',
                    prefix: Icons.email,
                  ),
                  SizedBox(height: 20),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: 'Enter A Phone',
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(height: 20),
                  defaultButton(
                    whenPress: () {
                      if (formKeys.currentState.validate()) {
                        ShopCubit.get(context).updateUserProfile(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'UPDATE',
                  ),
                  SizedBox(height: 20),
                  defaultButton(
                    whenPress: () {
                      signOut(context);
                    },
                    text: 'SignOut',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        // if (state is ShopSuccessUserProfileState) {
        //   print(state.loginModal.data.name);
        //   print(state.loginModal.data.email);
        //   print(state.loginModal.data.phone);
        //   nameController.text = state.loginModal.data.name;
        //   emailController.text = state.loginModal.data.email;
        //   phoneController.text = state.loginModal.data.phone;
        // }
      },
    );
  }
}
