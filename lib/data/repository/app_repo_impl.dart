import 'package:qas/domain/entities/login/login_response.dart';
import 'package:qas/domain/entities/login/refresh.dart';
import 'package:qas/domain/entities/response/response.dart';

import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/model.dart';
import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/pagenation/pagination.dart';
import '../../domain/repository/app_repo.dart';
import '../remote/api/api_service.dart';

class AppRepoImpl extends AppRepo {
  final ApiService _api;

  AppRepoImpl(this._api);

  @override
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest) =>
      _api.login(loginRequest);

  @override
  Stream<CustomResponse<LoginResponse>> refresh(Refresh refresh) =>
      _api.refreshToken(refresh);

  @override
  Stream<CustomResponse<Pagination<Car>>> cars(Map<String, dynamic>? queries) =>
      _api.cars(queries: queries);

  @override
  Stream<CustomResponse<Pagination<Model>>> models() => _api.models();

  @override
  Stream<CustomResponse<Car>> carById(int? id) => _api.carById(id);
}
