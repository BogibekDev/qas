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
            return 'Упс! Слабый интернет, проверьте ваше сетевое соединение.';
          }
          switch (error.type) {
            case DioExceptionType.badResponse:
              var errorBody = error.response?.data['result'];
              if (errorBody != null) return errorBody;

              return 'Неверный запрос: код статуса ${error.response?.statusCode}';
            default:
              return 'Please try again.';
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
        ? 'Невозможно обработать'
        : 'Неожиданная ошибка';
  }
}
