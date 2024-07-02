import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/response/response.dart';
import '../../main.dart';
import '../../tools/res_color.dart';

FToast fToast = FToast().init(navigatorKey.currentState!.context);
// void showError(String message) {
//
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

void toastError(Error? e) {
  final errorMessage =
      "Хатолик : ${e?.message ?? e?.birthYear ?? e?.detail ?? e?.statusCode}";
  fToast.removeCustomToast();
  fToast.showToast(
    gravity: ToastGravity.TOP,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: ResColors.white,
              size: 35,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                errorMessage,
                style: const TextStyle(
                  color: ResColors.white,
                  overflow: TextOverflow.clip,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
