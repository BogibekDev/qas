import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/response/response.dart';

class ErrorParser {
  static Error parse(error) {
    final err = Error.empty();
    if (kDebugMode) {
      log(error.toString());
    }
    if (error is Exception) {
      try {
        if (error is DioException) {
          err.statusCode = error.response?.statusCode;
          if (error.error is SocketException) {
            err.message =
                "Вой! Интернет алоқаси заиф, тармоқ уланишингизни текширинг.";
            return err;
          }
          switch (error.type) {
            case DioExceptionType.badResponse:
              var errorBody = error.response;
              if (errorBody != null) {
                if (errorBody.data["error"] != null) {
                  var err = Error.fromJson(errorBody.data["error"]);
                  return err..statusCode = error.response?.statusCode;
                } else {
                  return Error.fromJson(errorBody.data)
                    ..statusCode = error.response?.statusCode;
                }
              }

              return err..message = "Нотўғри сўров";
            default:
              return err..message = 'Илтимос, яна бир бор уриниб кўринг.';
          }
        }

        return Error.fromJson(error as Map<String, dynamic>);
      } on FormatException catch (e) {
        log("Error parser $e");
        return err..message = 'Ошибка типа формата';
      } catch (e) {
        log("Error parser catch $e");
        return err..message = 'Кутилмаган хато';
      }
    }

    return err..message = 'Кутилмаган хато';
  }
}
