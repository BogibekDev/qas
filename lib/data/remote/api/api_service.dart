import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/entities/detail/return.dart';
import '../../../domain/entities/detail/return_response.dart';
import '../../../domain/entities/home/car.dart';
import '../../../domain/entities/home/model.dart';
import '../../../domain/entities/login/login_request.dart';
import '../../../domain/entities/login/login_response.dart';
import '../../../domain/entities/login/refresh.dart';
import '../../../domain/entities/pagenation/pagination.dart';
import '../../../domain/entities/response/response.dart';
import '../../../domain/entities/sell/buyer.dart';
import '../../../domain/entities/sell/sell_request.dart';
import '../../../domain/entities/sell/sell_response.dart';
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

  @POST(ApiConst.refresh)
  Stream<CustomResponse<LoginResponse>> refreshToken(@Body() Refresh refresh);

  @GET(ApiConst.cars)
  Stream<CustomResponse<Pagination<Car>>> cars({
    @Queries() Map<String, dynamic>? queries,
  });

  @GET(ApiConst.models)
  Stream<CustomResponse<Pagination<Model>>> models();

  @GET("${ApiConst.carById}/{id}")
  Stream<CustomResponse<Car>> carById(@Path("id") int? id);

  @POST(ApiConst.carReturn)
  Stream<CustomResponse<ReturnResponse>> carReturn(
      @Body() Return returnRequest);

  @GET(ApiConst.buyers)
  Stream<CustomResponse<Pagination<Buyer>>> buyers(
      {@Query("search") String? search});

  @POST(ApiConst.buyers)
  Stream<CustomResponse<Buyer>> addBuyer(@Body() Buyer buyer);

  @POST(ApiConst.sellCar)
  Stream<CustomResponse<SellResponse>> sellCar(@Body() SellRequest sellRequest);
}
