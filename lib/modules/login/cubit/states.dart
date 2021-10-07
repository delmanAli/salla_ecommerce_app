import 'package:sala_shop_app/models/user_modal.dart';

abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  final LoginModal loginModel;

  LoginSuccessStates(this.loginModel);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}

class LoginChangePasswordStates extends LoginStates {}
