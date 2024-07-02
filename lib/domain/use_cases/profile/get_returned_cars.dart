import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/pagenation/pagination.dart';
import '../../entities/profile/returned.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class GetReturnedCars{
  final AppRepo _repo;

  GetReturnedCars(this._repo);
  Stream<Result<CustomResponse<Pagination<Returned>>>> execute() => _repo
      .getReturnedCars()
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}