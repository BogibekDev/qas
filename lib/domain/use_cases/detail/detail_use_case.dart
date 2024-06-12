import 'package:qas/data/tools/error_parser.dart';
import 'package:rxdart/rxdart.dart';

import '../../entities/home/car.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class DetailUseCase {
  final AppRepo _repo;

  DetailUseCase(this._repo);

  Stream<Result<CustomResponse<Car>>> execute(int? id) => _repo
      .carById(id)
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrack) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
