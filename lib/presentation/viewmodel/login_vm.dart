import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../data/local/prefs.dart';
import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/use_cases/login/login_use_case.dart';
import '../widget/toast.dart';

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

  void login() {
    final number = phoneNumberController.text;
    final password = passwordController.text;

    if (password.length >= 6 && number.length == 9) {
      LoginRequest request = LoginRequest('+998$number', password);

      _loginApi(
        request,
        () {
          goHome?.call();
        },
      );
    } else {
      errorMessage = "Telefon nomer yoki parol to'g'ri kiritilmagan";
      toastError(Error.empty()..message = errorMessage);
    }
  }

  void _loginApi(
    request,
    Function() goHome,
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
            if (response.success && response.data.role == "seller") {
              SharedPrefs.saveLogin();
              SharedPrefs.saveToken(response.data.access ?? "");
              SharedPrefs.saveRefreshToken(response.data.refresh ?? "");
              goHome.call();
            }
          },
          error: (error) {
            toastError(error);
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
  @override
  void dispose() {
    dispose();
    super.dispose();
  }
}
