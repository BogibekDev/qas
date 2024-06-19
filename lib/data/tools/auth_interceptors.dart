import 'dart:developer';

import 'package:dio/dio.dart';
import '../local/prefs.dart';

class AuthInterceptor extends InterceptorsWrapper {
  late RequestOptions options;
  late RequestInterceptorHandler handler;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    this.options = options;
    this.handler = handler;
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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log("Error in interceptor ${handler.toString()} : ${err.requestOptions.data}");
      super.onError(err, handler);
  }
}
