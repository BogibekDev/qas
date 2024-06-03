import 'package:qas/data/server/error_parser.dart';
import 'package:qas/domain/entities/login/login_request.dart';
import 'package:qas/domain/entities/result/result.dart';
import 'package:qas/domain/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';

class LoginUseCase {
  final AppRepo _repo;

  LoginUseCase(this._repo);

  Stream<Result<dynamic>> execute(LoginRequest loginRequest) => _repo
      .login(loginRequest)
      .map((response) {
        return Result.content(response);
      })
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
