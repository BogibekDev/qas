import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../entities/sell/buyer.dart';
import '../../repository/app_repo.dart';

class AddBuyer {
  final AppRepo _repo;

  AddBuyer(this._repo);

  Stream<Result<CustomResponse<Buyer>>> execute(Buyer buyer) => _repo
      .addBuyer(buyer)
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
