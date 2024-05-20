import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future error(BuildContext context, String errorText) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      headerAnimationLoop: false,
      title: "",
      desc: "$errorText\n",
      descTextStyle: const TextStyle(fontSize: 20),
      autoHide: const Duration(seconds: 3),
    ).show();
  }
}
