import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../entities/sell/sell_request.dart';
import '../../entities/sell/sell_response.dart';
import '../../repository/app_repo.dart';

class SellCar {
  final AppRepo _repo;

  SellCar(this._repo);

  Stream<Result<CustomResponse<SellResponse>>> execute(
          SellRequest request) => _repo
          .sellCar(request)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
