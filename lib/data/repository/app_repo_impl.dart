import '../../domain/entities/detail/return.dart';
import '../../domain/entities/detail/return_response.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/model.dart';
import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/login/login_response.dart';
import '../../domain/entities/pagenation/pagination.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/entities/sell/buyer.dart';
import '../../domain/entities/sell/sell_request.dart';
import '../../domain/entities/sell/sell_response.dart';
import '../../domain/entities/sold_car/sold_car.dart';
import '../../domain/repository/app_repo.dart';
import '../remote/api/api_service.dart';

class AppRepoImpl extends AppRepo {
  final ApiService _api;

  AppRepoImpl(this._api);

  @override
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest) =>
      _api.login(loginRequest);

  @override
  Stream<CustomResponse<Pagination<Car>>> cars(Map<String, dynamic>? queries) =>
      _api.cars(queries: queries);

  @override
  Stream<CustomResponse<Pagination<Model>>> models() => _api.models();

  @override
  Stream<CustomResponse<Car>> carById(int? id) => _api.carById(id);

  @override
  Stream<CustomResponse<ReturnResponse>> carReturn(Return returnRequest) =>
      _api.carReturn(returnRequest);

  @override
  Stream<CustomResponse<Pagination<Buyer>>> buyers(String? search) =>
      _api.buyers(search: search);

  @override
  Stream<CustomResponse<Buyer>> addBuyer(Buyer buyer) => _api.addBuyer(buyer);

  @override
  Stream<CustomResponse<SellResponse>> sellCar(SellRequest request) =>
      _api.sellCar(request);

  @override
  Stream<CustomResponse<Pagination<Car>>> soldCars(int? count) =>
      _api.soldCars(count: count);

  @override
  Stream<CustomResponse<SoldCar>> getSoldCar(int? id) => _api.getSoldCar(id);
}
