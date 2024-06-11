import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/entities/login/login_response.dart';
import 'package:qas/domain/entities/response/response.dart';
import 'package:retrofit/http.dart';

import '../entities/home/car.dart';
import '../entities/home/pagination.dart';

abstract class AppRepo {
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest);

  Stream<CustomResponse<Pagination<Car>>> cars({
    @Query("page") int page = 1,
    @Query("model") String? model,
    @Query("min_year") int? minYear,
    @Query("max_year") int? maxYear,
    @Query("min_price") int? minPrice,
    @Query("max_price") int? maxPrice,
  });
}
