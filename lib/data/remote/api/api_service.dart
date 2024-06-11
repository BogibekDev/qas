import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qas/domain/entities/home/car.dart';
import 'package:qas/domain/entities/home/pagination.dart';
import 'package:retrofit/http.dart';

import '../../../domain/entities/home/model.dart';
import '../../../domain/entities/login/login_request.dart';
import '../../../domain/entities/login/login_response.dart';
import '../../../domain/entities/response/response.dart';
import '../../tools/auth_interceptors.dart';
import 'api_const.dart';

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
  Stream<CustomResponse<LoginResponse>> login(@Body() LoginRequest request);

  @GET(ApiConst.cars)
  Stream<CustomResponse<Pagination<Car>>> cars({
    @Queries() Map<String, dynamic>? queries,
  });

  @GET(ApiConst.models)
  Stream<CustomResponse<Pagination<Model>>> models();
}
