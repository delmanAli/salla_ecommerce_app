import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/shop_layout.dart';
import 'package:sala_shop_app/modules/register/cubit/cubit.dart';
import 'package:sala_shop_app/modules/register/cubit/states.dart';
import 'package:sala_shop_app/shared/components/default_buttom.dart';
import 'package:sala_shop_app/shared/components/default_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          // if (state is RegisterSuccessState) {
          //   if (state.userModal.status) {}
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Form(
                key: formKeys,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                ' Register Now',
                                speed: Duration(milliseconds: 350),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          // Text(
                          //   'Register',
                          //   style: Theme.of(context).textTheme.headline4,
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Register to see our hot items',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: 'Enter Your Name',
                            label: 'User Name',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: 'Enter Your Email',
                            label: 'Email',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: 'Enter Your Password',
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            isPassword:
                                RegisterCubit.get(context).isPasswordHidden,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: 'Enter Your Phone',
                            label: 'Phone Number',
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (state is RegisterLoadingStates)
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          if (state is! RegisterLoadingStates)
                            defaultButton(
                              whenPress: () {
                                if (formKeys.currentState.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    phone: phoneController.text.trim(),
                                  );
                                }
                                Navigator.pushReplacementNamed(
                                  context,
                                  HomePage.routeName,
                                );
                              },
                              text: 'Register',
                              upperCase: true,
                              fullWidth: true,
                            ),
                        ],
                      ),
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
