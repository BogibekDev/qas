import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qas/data/server/api/api_service.dart';
import 'package:qas/data/server/auth_interceptors.dart';
import 'package:qas/domain/repo/app_repo.dart';
import 'package:qas/domain/repo/app_repo_impl.dart';
import 'package:qas/domain/use_cases/login/login_use_case.dart';

/// repositories ---------------------------------------------------------------
final repoProvider =
    Provider<AppRepo>((ref) => AppRepoImpl(ref.read(apiProvider)));

/// server ---------------------------------------------------------------------
final authInterceptorProvider =
    Provider<AuthInterceptor>((ref) => AuthInterceptor());

final apiProvider = Provider<ApiService>(
    (ref) => ApiService(ref.read(authInterceptorProvider)));

final loginUseCase = Provider((ref) => LoginUseCase(ref.read(repoProvider)));
