// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/models/user_modal.dart';
import 'package:sala_shop_app/modules/login/cubit/states.dart';
// import 'package:sala_shop_app/shared/network/local/cach_helper.dart';
import 'package:sala_shop_app/shared/network/remote/dio_helper.dart';
import 'package:sala_shop_app/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModal userModal;

  void userSignIn({
    @required email,
    @required password,
  }) async {
    emit(LoginLoadingStates());

    // try {
    //   var res = await DioHelper.postData(
    //     url: LOGIN,
    //     data: {
    //       'email': email,
    //       'password': password,
    //     },
    //   );
    //   userModal = LoginModal.fromJson(res.data);
    //   if (userModal.status) {
    //     print('success');
    //     // print(userModal.data.name);
    //     // print(userModal.data.token);
    //     CacheHelper.setData(
    //       key: 'userData',
    //       value: JsonEncoder(res.data),
    //     );
    //   } else {
    //     print(userModal.message);
    //   }
    //   emit(LoginSuccessStates());
    // } catch (erorr) {
    //   print(erorr.toString());
    //   emit(LoginErrorStates(erorr));
    // }

    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      userModal = LoginModal.fromJson(value.data);
      if (userModal.status) {
        print('success');
        print(userModal.data.name);
        print(userModal.data.token);
      } else {
        print(userModal.message);
      }
      emit(LoginSuccessStates(userModal));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordHidden = true;

  void changePasswordVisibility() {
    suffix = Icons.visibility_off_outlined;
    isPasswordHidden = !isPasswordHidden;
    suffix = isPasswordHidden
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(LoginChangePasswordStates());
  }
}
