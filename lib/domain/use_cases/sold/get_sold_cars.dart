import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/home/car.dart';
import '../../entities/pagenation/pagination.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class GetSoldCars {
  final AppRepo _repo;

  GetSoldCars(this._repo);

  Stream<Result<CustomResponse<Pagination<Car>>>> execute(int? count) => _repo
      .soldCars(count)
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
