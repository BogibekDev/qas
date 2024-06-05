import 'package:flutter/material.dart';
import 'package:qas/config/base_vm.dart';
import 'package:qas/data/remote/local/prefs.dart';
import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/use_cases/login/login_use_case.dart';

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

      _loginApi(request, () {
        goHome?.call();
      });
    } else {
      errorMessage = "Telefon nomer yoki paroll";
      notifyListeners();
    }
  }

  void _loginApi(request, Function() goHome) {
    _loginUseCase.execute(request).listen(
      (event) {
        event.when(
            loading: () {
              isLoading = true;
              notifyListeners();
            },
            content: (response) {
              if (response.success) {
                SharedPrefs.saveLogin();
                SharedPrefs.saveToken(response.data.access);
                SharedPrefs.saveRefreshToken(response.data.refresh);
                goHome.call();
              } else {}
            },
            error: (errorMessage) {});
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

  void showMessage(BuildContext context) {
    AlertDialog.adaptive(
      content: Row(
        children: [Text(errorMessage)],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).maybePop();
        }, child: Text("ok"))
      ],
    );
  }
}
