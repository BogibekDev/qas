import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../tools/dimens.dart';
import '../../tools/prefs.dart';
import '../../tools/res_color.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPhoneError = false;
  bool isPasswordShow = false;
  bool isLogin = false;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    checkIsLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _phoneNumberController,
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
                controller: _passwordController,
                obscureText: !isPasswordShow,
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
                      onPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      },
                      icon: !isPasswordShow
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
                  onPressed: () {
                    final number = _phoneNumberController.text;
                    final password = _passwordController.text;
                    if (password.length >= 6 && number.length == 9) {
                      SharedPrefs.saveLogin();
                      SharedPrefs.saveToken("token");
                      goHomePage();
                    } else {}
                  },
                  child: Text(
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

  void goHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void checkIsLogin() async {
    isLogin = await SharedPrefs.isLogin();
    if (isLogin) {
      goHomePage();
    }
  }
}
