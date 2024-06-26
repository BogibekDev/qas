
import '../entities/detail/return.dart';
import '../entities/detail/return_response.dart';
import '../entities/home/car.dart';
import '../entities/home/model.dart';
import '../entities/login/login_request.dart';
import '../entities/login/login_response.dart';
import '../entities/login/refresh.dart';
import '../entities/pagenation/pagination.dart';
import '../entities/response/response.dart';
import '../entities/sell/buyer.dart';

abstract class AppRepo {
  Stream<CustomResponse<LoginResponse>> login(LoginRequest loginRequest);
  Stream<CustomResponse<LoginResponse>> refresh(Refresh refresh);
  Stream<CustomResponse<Pagination<Car>>> cars(Map<String,dynamic>? queries);
  Stream<CustomResponse<Pagination<Model>>> models();
  Stream<CustomResponse<Car>> carById( int? id);
  Stream<CustomResponse<ReturnResponse>> carReturn(Return returnRequest);
  Stream<CustomResponse<Pagination<Buyer>>> buyers(String? search);
}
