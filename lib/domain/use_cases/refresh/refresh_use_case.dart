
import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/login/login_response.dart';
import '../../entities/login/refresh.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class RefreshUseCase{
  final AppRepo _repo;

  RefreshUseCase(this._repo);
  Stream<Result<CustomResponse<LoginResponse>>> execute(
      Refresh refresh) =>
      _repo
          .refresh(refresh)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}