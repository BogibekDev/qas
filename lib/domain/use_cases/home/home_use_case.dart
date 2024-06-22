import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/home/car.dart';
import '../../entities/pagenation/pagination.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class GetCars {
  final AppRepo _repo;

  GetCars(this._repo);

  Stream<Result<CustomResponse<Pagination<Car>>>> execute(
          Map<String, dynamic>? queries) =>
      _repo
          .cars(queries)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
