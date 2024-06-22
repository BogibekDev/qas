import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/home/model.dart';
import '../../entities/pagenation/pagination.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class GetModels {
  final AppRepo _repo;

  const GetModels(this._repo);

  Stream<Result<CustomResponse<Pagination<Model>>>> execute() => _repo
      .models()
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrace) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
