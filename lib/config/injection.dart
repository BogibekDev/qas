import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/remote/api/api_service.dart';
import '../data/repository/app_repo_impl.dart';
import '../data/tools/auth_interceptors.dart';
import '../domain/repository/app_repo.dart';
import '../domain/use_cases/detail/car_return.dart';
import '../domain/use_cases/detail/detail_use_case.dart';
import '../domain/use_cases/home/get_models.dart';
import '../domain/use_cases/home/home_use_case.dart';
import '../domain/use_cases/login/login_use_case.dart';
import '../domain/use_cases/refresh/refresh_use_case.dart';
import '../domain/use_cases/sell/add_buyer.dart';
import '../domain/use_cases/sell/getBuyers.dart';
import '../domain/use_cases/sell/sell_car.dart';

/// repositories ---------------------------------------------------------------
final repoProvider =
    Provider<AppRepo>((ref) => AppRepoImpl(ref.read(apiProvider)));

/// server ---------------------------------------------------------------------
final authInterceptorProvider =
    Provider<AuthInterceptor>((ref) => AuthInterceptor());

final apiProvider = Provider<ApiService>(
    (ref) => ApiService(ref.read(authInterceptorProvider)));

final loginUseCase = Provider((ref) => LoginUseCase(ref.read(repoProvider)));
final refreshUseCase =
    Provider((ref) => RefreshUseCase(ref.read(repoProvider)));
final getCars = Provider((ref) => GetCars(ref.read(repoProvider)));
final getModels = Provider((ref) => GetModels(ref.read(repoProvider)));
final detailUseCase = Provider((ref) => DetailUseCase(ref.read(repoProvider)));
final carReturn = Provider((ref) => CarReturn(ref.read(repoProvider)));
final getBuyers = Provider((ref) => GetBuyers(ref.read(repoProvider)));
final addBuyer = Provider((ref) => AddBuyer(ref.read(repoProvider)));
final sellCar = Provider((ref) => SellCar(ref.read(repoProvider)));
