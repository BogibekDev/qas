import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorParser {
  static String parse(error) {
    if (kDebugMode) {
      log(error.toString());
    }
    if (error is Exception) {
      try {
        if (error is DioException) {
          if (error.error is SocketException) {
            return 'Вой! Интернет алоқаси заиф, тармоқ уланишингизни текширинг.';
          }
          switch (error.type) {
            case DioExceptionType.badResponse:
              var errorBody = error.response?.data['result'];
              if (errorBody != null) return errorBody;

              return 'Нотўғри сўров: ҳолат коди ${error.response?.statusCode}';
            default:
              return 'Илтимос, яна бир бор уриниб кўринг.';
          }
        }

        return error.toString();
      } on FormatException catch (e) {
        log("Error parser $e");
        return 'Ошибка типа формата';
      } catch (e) {
        log("Error parser catch $e");
        return 'Неожиданная ошибка';
      }
    }
    return error.toString().contains("is not a subtype of")
        ? 'Қайта ишлаш имконсиз'
        : 'Кутилмаган хато';
  }
}
