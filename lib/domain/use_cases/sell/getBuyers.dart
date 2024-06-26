import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/pagenation/pagination.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../entities/sell/buyer.dart';
import '../../repository/app_repo.dart';

class GetBuyers {
  final AppRepo _repo;

  GetBuyers(this._repo);

  Stream<Result<CustomResponse<Pagination<Buyer>>>> execute(
          String? search) =>
      _repo
          .buyers(search)
          .map((response) => Result.content(response))
          .onErrorReturnWith(
              (error, stackTrace) => Result.error(ErrorParser.parse(error)))
          .startWith(const Result.loading());
}
