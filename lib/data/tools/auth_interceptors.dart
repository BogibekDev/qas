import 'dart:developer';

import 'package:dio/dio.dart';

import '../../domain/entities/response/response.dart';
import '../../presentation/viewmodel/refresh_token.dart';
import '../local/prefs.dart';

class AuthInterceptor extends InterceptorsWrapper {
  bool isRefreshing = false;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String authToken = await SharedPrefs.getToken();
    if (authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }

    log("Data in interceptor${options.data}");
    log("request ketdi : ${DateTime.now()}");
    log("Extra in interceptor${options.extra}");
    log("QueryParams in interceptor${options.queryParameters}");
    log("content in interceptor${options.contentType}");
    log("headers in interceptor${options.headers}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log("Response in interceptor ${handler.toString()} : $response");
    log("respose keldi : ${DateTime.now()}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("Error in interceptor ${handler.toString()} : ${err.requestOptions.data}");
    super.onError(err, handler);
  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) async {
  //   log("Error in interceptor ${handler.toString()} : ${err.requestOptions.data}");
  //   executeRefresh(err, handler);
  // }

  void executeRefresh(DioException err, ErrorInterceptorHandler handler) async {
    log("executeRefresh: onError : statusCode: ${err.response?.statusCode}");
    log("executeRefresh: onError : data: ${err.response?.data}");
    log("executeRefresh: onError : statusMessage: ${err.response?.statusMessage}");

    if (err.response?.statusCode == 401) {
      if (!isRefreshing) {
        isRefreshing = true;
        var errorModel = Error.fromJson(err.response?.data)..statusCode = err.response?.statusCode;
        await RefreshToken().execute(
          err: errorModel,
          callBack: () {

          },
        );
      }
    } else {
      handler.next(err);
    }
  }
}
