import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/detail/return.dart';
import '../../entities/detail/return_response.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class CarReturn {
  final AppRepo _repo;

  CarReturn(this._repo);

  Stream<Result<CustomResponse<ReturnResponse>>> execute(
          Return returnRequest) => _repo
          .carReturn(returnRequest)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrack) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
