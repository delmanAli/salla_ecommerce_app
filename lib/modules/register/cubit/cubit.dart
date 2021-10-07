import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/models/user_modal.dart';
import 'package:sala_shop_app/modules/register/cubit/states.dart';
import 'package:sala_shop_app/shared/network/local/cach_helper.dart';
import 'package:sala_shop_app/shared/network/remote/dio_helper.dart';
import 'package:sala_shop_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModal userModal;

  void userRegister({
    @required name,
    @required email,
    @required password,
    @required phone,
  }) async {
    emit(RegisterLoadingStates());

    // try {
    //   final res = await DioHelper.postData(
    //     url: REGISTER,
    //     data: {
    //       'name': name,
    //       'email': email,
    //       'password': password,
    //       'phone': phone,
    //     },
    //   );
    //   userModal = UserModal.fromJson(res.data);
    //   if (userModal.status) {
    //     print('success');
    //     print(userModal.data.name);
    //     print(userModal.data.token);
    //     CacheHelper.setData(
    //       key: 'userData',
    //       value: JsonEncoder(res.data),
    //     );
    //   } else {
    //     print(userModal.message.toString());
    //   }
    //   emit(RegisterSuccessStates());
    // } catch (erorr) {
    //   print(erorr.toString());
    //   emit(RegisterErrorStates(erorr));
    // }

    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      userModal = LoginModal.fromJson(value.data);
      CacheHelper.setData(
        key: 'userData',
        value: JsonEncoder(value.data),
      );
      emit(RegisterSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorStates(error));
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

    emit(RegisterChangePasswordStates());
  }
}
