import 'package:flutter/material.dart';
import 'package:qas/config/base_vm.dart';
import 'package:qas/tools/prefs.dart';

class LoginVM extends BaseVM {
  bool isPhoneError = false;
  bool isPasswordShow = false;
  bool isLogin = false;

  Function()? goHome;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginVM() {
    checkIsLogin();
  }

  void checkIsLogin() async {
    isLogin = await SharedPrefs.isLogin();
    if (isLogin) goHome?.call();
  }

  void login() {
    final number = phoneNumberController.text;
    final password = passwordController.text;
    if (password.length >= 6 && number.length == 9) {
      SharedPrefs.saveLogin();
      SharedPrefs.saveToken("token");
      goHome?.call();
    } else {}
  }

  void changePasswordShow() {
    isPasswordShow = !isPasswordShow;
    notifyListeners();
  }
}
