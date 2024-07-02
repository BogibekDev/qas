import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../entities/sold_car/sold_car.dart';
import '../../repository/app_repo.dart';

class GetSoldCar {
  final AppRepo _repo;

  GetSoldCar(this._repo);

  Stream<Result<CustomResponse<SoldCar>>> execute(int? id) => _repo
      .getSoldCar(id)
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
