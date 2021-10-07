import 'package:flutter/cupertino.dart';
import 'package:sala_shop_app/modules/login/login_screen.dart';

String token = '';

void signOut(context) {
  Navigator.pushReplacementNamed(
    context,
    LoginScreen.routeName,
  );
}
