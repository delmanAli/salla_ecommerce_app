import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/shop_layout.dart';
import 'package:sala_shop_app/modules/login/cubit/cubit.dart';
import 'package:sala_shop_app/modules/login/cubit/states.dart';
import 'package:sala_shop_app/modules/register/register_screen.dart';
import 'package:sala_shop_app/shared/components/custom_navigator.dart';
import 'package:sala_shop_app/shared/components/default_buttom.dart';
import 'package:sala_shop_app/shared/components/default_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'logIn';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
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
                                ' Login Now',
                                speed: Duration(milliseconds: 350),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          // Text(
                          //   'login',
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .headline4
                          //       .copyWith(color: Colors.black),
                          // ),
                          SizedBox(height: 20),
                          Text('login to see our hot items',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.grey,
                                  )),
                          SizedBox(height: 30),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: 'Enter Your Email',
                            label: 'Email',
                            prefix: Icons.email_outlined,
                          ),
                          SizedBox(height: 15),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              LoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: 'Enter Your Password',
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            isPassword:
                                LoginCubit.get(context).isPasswordHidden,
                          ),
                          SizedBox(height: 20),
                          if (state is LoginLoadingStates)
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          if (state is! LoginLoadingStates)
                            defaultButton(
                              whenPress: () {
                                if (formKeys.currentState.validate()) {
                                  LoginCubit.get(context).userSignIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    HomePage.routeName,
                                  );
                                }
                              },
                              text: 'Login',
                              upperCase: true,
                              fullWidth: true,
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  // navigateTo(
                                  //   context: context,
                                  //   widget: RegisterScreen(),
                                  // );
                                  navigateToNamed(
                                    context: context,
                                    widget: RegisterScreen.routeName,
                                  );
                                },
                                child: Text('Register Now'),
                              ),
                            ],
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
