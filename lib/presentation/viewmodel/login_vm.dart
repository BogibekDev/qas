import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../data/local/prefs.dart';
import '../../domain/entities/login/login_request.dart';
import '../../domain/use_cases/login/login_use_case.dart';

class LoginViewModel extends BaseViewModel {
  final LoginUseCase _loginUseCase;
  bool isLoading = false;
  var errorMessage = "";
  bool isPasswordShow = false;
  bool isLogin = false;

  Function()? goHome;

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginViewModel(this._loginUseCase) {
    checkIsLogin();
  }

  void checkIsLogin() async {
    isLogin = await SharedPrefs.isLogin();
    if (isLogin) goHome?.call();
  }

  void login(Function(String) showError) {
    final number = phoneNumberController.text;
    final password = passwordController.text;

    if (password.length >= 6 && number.length == 9) {
      LoginRequest request = LoginRequest('+998$number', password);

      _loginApi(request, () {
        goHome?.call();
      }, (String error) {
        showError(error);
      });
    } else {
      errorMessage = "Telefon nomer yoki parol to'g'ri kiritilmagan";
      showError(errorMessage);
    }
  }

  void _loginApi(
    request,
    Function() goHome,
    Function(String) showError,
  ) {
    _loginUseCase.execute(request).listen(
      (event) {
        event.when(
          loading: () {
            errorMessage = "";
            isLoading = true;
            notifyListeners();
          },
          content: (response) {
            if (response.success) {
              SharedPrefs.saveLogin();
              SharedPrefs.saveToken(response.data.access ?? "");
              SharedPrefs.saveRefreshToken(response.data.refresh ?? "");
              goHome.call();
            } else {
              showError(response.error!.message);
            }
          },
          error: (errorMessage) {
            showError(errorMessage ?? "");
          },
        );
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
