import 'package:flutter/material.dart';
import 'package:qas/config/base_vm.dart';
import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/use_cases/login/login_use_case.dart';
import 'package:qas/tools/prefs.dart';

class LoginVM extends BaseVM {
  final LoginUseCase _loginUseCase;
  bool isLoading = false;
  bool isPhoneError = false;
  bool isPasswordShow = false;
  bool isLogin = false;

  Function()? goHome;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginVM(this._loginUseCase) {
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
      LoginRequest request = LoginRequest('+998$number', password);

      _loginApi(request, () {
        goHome?.call();
      });
    } else {}
  }

  void _loginApi(request, Function() goHome) {
    _loginUseCase.execute(request).listen(
      (event) {
        event.when(loading: () {
          isLoading = true;
          notifyListeners();
        }, content: (response) {
          print(response);
          SharedPrefs.saveLogin();
          SharedPrefs.saveToken("token");
          goHome.call();
        }, error: (errorMessage) {
          print(errorMessage);
        });
      },
    ).onDone(() {
      isLoading = false;
      notifyListeners();
    });
  }

  void changePasswordShow() {
    isPasswordShow = !isPasswordShow;
    notifyListeners();
  }
}
