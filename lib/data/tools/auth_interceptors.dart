import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../domain/entities/login/refresh.dart';
import '../../domain/entities/response/response.dart';
import '../../main.dart';
import '../../presentation/widget/toast.dart';
import '../local/prefs.dart';
import '../remote/api/api_service.dart';

class AuthInterceptor extends InterceptorsWrapper {
  bool isRefreshing = false;
  final Dio dio;
  final ApiService apiService;

  AuthInterceptor(this.dio, this.apiService);

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
    log("Error in interceptor : statusCode : ${err.response?.statusCode}");
    log("Error in interceptor : data : ${err.response?.data}");
    log("Error in interceptor : statusMessage : ${err.response?.statusMessage}");
    log("Error in interceptor : error : ${err.error}");
    log("Error in interceptor : message : ${err.message}");
    log("Error in interceptor : message : ${err.type}");
    if (err.response?.statusCode == 401) {
      executeRefresh(err, handler);
    } else {
      handler.next(err); // Let the error pass through if it's not a 401
    }
  }

  void executeRefresh(DioException err, ErrorInterceptorHandler handler) async {
    if (!isRefreshing) {
      isRefreshing = true;
      try {
        String refreshToken = await SharedPrefs.getRefreshToken();
        if (refreshToken.isNotEmpty) {
          final response = await apiService.refreshToken(Refresh(refreshToken));
          if (response.success) {
            await SharedPrefs.saveToken(response.data.access ?? "");
            await SharedPrefs.saveRefreshToken(response.data.refresh ?? "");

            // Retry the failed request
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer ${response.data.access}';

            final failedRequest = await dio.request(
              options.path,
              options: Options(
                method: options.method,
                headers: options.headers,
              ),
              data: options.data,
              queryParameters: options.queryParameters,
            );

            handler.resolve(failedRequest);
          } else if (response.error?.code == "invalid" ||
              response.error?.detail == "Token is invalid" ||
              response.error?.detail == "Token is invalid or expired") {
            goLogin();
          }
        }
      } catch (e) {
        handler.next(err); // Let the error pass through if something fails
        goLogin();
      } finally {
        isRefreshing = false;
      }
    } else {
      goLogin();
    }
  }

  void goLogin() {
    toastError(Error.empty()..message = "loginMessage".tr());
    SharedPrefs.saveLogOut();
    navigatorKey.currentState?.pushReplacementNamed("/login");
  }
}
