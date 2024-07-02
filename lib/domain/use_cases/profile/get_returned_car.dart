import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/profile/returned_detail.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class GetReturnedCar {
  final AppRepo _repo;

  GetReturnedCar(this._repo);

  Stream<Result<CustomResponse<ReturnedDetail>>> execute(int? id) => _repo
      .getReturnedCar(id)
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrack) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
