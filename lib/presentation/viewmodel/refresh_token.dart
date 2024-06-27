import '../../data/local/prefs.dart';
import '../../data/remote/api/api_service.dart';
import '../../data/repository/app_repo_impl.dart';
import '../../data/tools/auth_interceptors.dart';
import '../../domain/entities/login/refresh.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/use_cases/refresh/refresh_use_case.dart';
import '../../main.dart';

class RefreshToken {
  final _refreshUseCase =
      RefreshUseCase(AppRepoImpl(ApiService(AuthInterceptor())));

  void execute({
    required Function callBack,
  }) async {
    final refresh = await SharedPrefs.getRefreshToken();
    await SharedPrefs.removeToken();
    _refreshUseCase.execute(Refresh(refresh)).listen((event) {
      event.when(
        loading: () {},
        content: (response) async {
          if (response.success) {
            await SharedPrefs.saveToken(response.data.access ?? "");
            await SharedPrefs.saveRefreshToken(response.data.refresh ?? "");
            callBack.call();
          }
        },
        error: (Error? error) {
          if (error?.statusCode == 401) {
            SharedPrefs.saveLogOut();
            navigatorKey.currentState?.pushReplacementNamed("/login");
          }
        },
      );
    }).onDone(() {});
  }
}
