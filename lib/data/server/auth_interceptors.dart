
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:qas/tools/prefs.dart';


class AuthInterceptor extends InterceptorsWrapper {


  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String authToken = await SharedPrefs.getToken();
    if (authToken.isNotEmpty == true) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    log("Data in interceptor${options.data}");
    log("Extra in interceptor${options.extra}");
    log("QueryParams in interceptor${options.queryParameters}");
    log("content in interceptor${options.contentType}");
    log("headers in interceptor${options.headers}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log("Response in interceptor ${handler.toString()} : $response");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log("Error in interceptor ${handler.toString()} : ${err.requestOptions}");
    super.onError(err, handler);
  }
}