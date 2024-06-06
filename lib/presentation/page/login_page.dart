import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/injection.dart';
import '../../tools/dimens.dart';
import '../../tools/res_color.dart';
import 'home_page.dart';
import '../viewmodel/login_vm.dart';

final loginNotifierProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(ref.read(loginUseCase));
});

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoginViewModel loginVM = ref.watch(loginNotifierProvider)
      ..goHome = () => goHomePage.call(context);

    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: Text(
          "login".tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ResColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.appMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                "phone_number".tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: ResColors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: loginVM.phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefix: Text(
                    "+998  ",
                    style: TextStyle(
                      fontSize: 18,
                      color: ResColors.black,
                    ),
                  ),
                ),
                maxLength: 9,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 18,
                  color: ResColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "password".tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: ResColors.black,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: loginVM.passwordController,
                obscureText: !loginVM.isPasswordShow,
                style: const TextStyle(
                  fontSize: 18,
                  color: ResColors.black,
                ),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "********",
                  hintStyle: const TextStyle(color: ResColors.black),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      onPressed: loginVM.changePasswordShow,
                      icon: loginVM.isPasswordShow
                          ? const Icon(CupertinoIcons.eye_fill)
                          : const Icon(CupertinoIcons.eye_slash_fill),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ResColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => loginVM.login((error) {
                    showErrorMessage(context, error);
                  }),
                  child: loginVM.isLoading
                      ? const CircularProgressIndicator(
                          color: ResColors.white,
                        )
                      : Text(
                          "login".tr(),
                          style: const TextStyle(
                            color: ResColors.white,
                            fontSize: 18,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void goHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ),
          const SizedBox(width: 16),
          Text(
            message,
            style: const TextStyle(color: ResColors.white),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
