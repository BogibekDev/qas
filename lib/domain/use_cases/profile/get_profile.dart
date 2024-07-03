import 'package:rxdart/rxdart.dart';

import '../../../data/tools/error_parser.dart';
import '../../entities/profile/profile.dart';
import '../../entities/response/response.dart';
import '../../entities/result/result.dart';
import '../../repository/app_repo.dart';

class GetProfile {
  final AppRepo _repo;

  GetProfile(this._repo);

  Stream<Result<CustomResponse<Profile>>> execute() => _repo
      .getProfile()
      .map((response) => Result.content(response))
      .onErrorReturnWith(
          (error, stackTrack) => Result.error(ErrorParser.parse(error)))
      .startWith(const Result.loading());
}
