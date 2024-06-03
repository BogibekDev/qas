import 'package:qas/data/server/api/api_service.dart';
import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/repo/app_repo.dart';

class AppRepoImpl extends AppRepo {
  final ApiService _api;

  AppRepoImpl(this._api);

  @override
  Stream<dynamic> login(LoginRequest loginRequest) => _api.login(loginRequest);
}
