import 'package:qas/data/tools/error_parser.dart';
import 'package:rxdart/rxdart.dart';

import '../../entities/home/car.dart';
import '../../entities/home/model.dart';
import '../../entities/home/pagination.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class HomeUseCase {
  final AppRepo _repo;

  HomeUseCase(this._repo);

  Stream<Result<CustomResponse<Pagination<Car>>>> execute(
          Map<String, dynamic>? queries) =>
      _repo
          .cars(queries)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());

  Stream<Result<CustomResponse<Pagination<Model>>>> modelsExecute() => _repo
      .models()
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
