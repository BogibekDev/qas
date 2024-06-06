import 'package:qas/domain/entities/login/login_response.dart';
import 'package:qas/domain/entities/response/response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/login/login_request.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class LoginUseCase {
  final AppRepo _repo;

  LoginUseCase(this._repo);

  Stream<Result<CustomResponse<LoginResponse>>> execute(
          LoginRequest loginRequest) =>
      _repo
          .login(loginRequest)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
