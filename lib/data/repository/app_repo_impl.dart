

import 'package:qas/domain/entities/login/login_response.dart';
import 'package:qas/domain/entities/response/response.dart';

import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/pagination.dart';
import '../../domain/repository/app_repo.dart';
import '../remote/api/api_service.dart';
import '../../domain/entities/login/login_request.dart';

class AppRepoImpl extends AppRepo {
  final ApiService _api;

  AppRepoImpl(this._api);

  @override
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest) => _api.login(loginRequest);

  @override
  Stream<CustomResponse<Pagination<Car>>> cars()=>_api.cars()
}
