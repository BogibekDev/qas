import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/entities/login/login_response.dart';
import 'package:qas/domain/entities/response/response.dart';

import '../entities/home/car.dart';
import '../entities/home/model.dart';
import '../entities/home/pagination.dart';

abstract class AppRepo {
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest);

  Stream<CustomResponse<Pagination<Car>>> cars(Map<String,dynamic>? queries);
  Stream<CustomResponse<Pagination<Model>>> models();
}
