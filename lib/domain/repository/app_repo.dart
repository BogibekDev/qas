import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/entities/login/login_response.dart';
import 'package:qas/domain/entities/response/response.dart';

abstract class AppRepo {
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest);
}
