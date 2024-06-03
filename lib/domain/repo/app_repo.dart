import 'package:qas/domain/entities/login/login_request.dart';

abstract class AppRepo {
  Stream<dynamic> login(LoginRequest loginRequest);
}
