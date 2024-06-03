import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qas/data/server/api/api_const.dart';
import 'package:qas/data/server/auth_interceptors.dart';
import 'package:qas/domain/entities/login/login_request.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(AuthInterceptor authInterceptor) {
    var options = BaseOptions(
      baseUrl: ApiConst.baseUrl,
    );
    Dio dio = Dio(options);
    dio.interceptors.add(authInterceptor);

    if (kDebugMode) dio.interceptors.add(LogInterceptor());

    return _ApiService(dio);
  }

  @POST(ApiConst.login)
  Stream<dynamic> login(@Body() LoginRequest loginRequest);
}
