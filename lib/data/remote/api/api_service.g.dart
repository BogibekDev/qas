// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Stream<CustomResponse<LoginResponse>> login(LoginRequest request) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<LoginResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/users/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<LoginResponse>.fromJson(
      _result.data!,
      (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Future<CustomResponse<LoginResponse>> refreshToken(Refresh refresh) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(refresh.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<LoginResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/users/token/refresh',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<LoginResponse>.fromJson(
      _result.data!,
      (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
    return _value;
  }

  @override
  Stream<CustomResponse<Pagination<Car>>> cars(
      {Map<String, dynamic>? queries}) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Pagination<Car>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/cars',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Pagination<Car>>.fromJson(
      _result.data!,
      (json) => Pagination<Car>.fromJson(
        json as Map<String, dynamic>,
        (json) => Car.fromJson(json as Map<String, dynamic>),
      ),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Pagination<Model>>> models({int? count = 1000}) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'count': count};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Pagination<Model>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/car-models',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Pagination<Model>>.fromJson(
      _result.data!,
      (json) => Pagination<Model>.fromJson(
        json as Map<String, dynamic>,
        (json) => Model.fromJson(json as Map<String, dynamic>),
      ),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Car>> carById(int? id) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Car>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/car/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Car>.fromJson(
      _result.data!,
      (json) => Car.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<ReturnResponse>> carReturn(
      Return returnRequest) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(returnRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<ReturnResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/back',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<ReturnResponse>.fromJson(
      _result.data!,
      (json) => ReturnResponse.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Pagination<Buyer>>> buyers({String? search}) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'search': search};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Pagination<Buyer>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/buyers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Pagination<Buyer>>.fromJson(
      _result.data!,
      (json) => Pagination<Buyer>.fromJson(
        json as Map<String, dynamic>,
        (json) => Buyer.fromJson(json as Map<String, dynamic>),
      ),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Buyer>> addBuyer(Buyer buyer) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(buyer.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Buyer>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/buyers',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Buyer>.fromJson(
      _result.data!,
      (json) => Buyer.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<SellResponse>> sellCar(SellRequest sellRequest) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(sellRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<SellResponse>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/sell',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<SellResponse>.fromJson(
      _result.data!,
      (json) => SellResponse.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Pagination<Car>>> soldCars({int? count = 100}) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'count': count};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Pagination<Car>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/sold-cars',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Pagination<Car>>.fromJson(
      _result.data!,
      (json) => Pagination<Car>.fromJson(
        json as Map<String, dynamic>,
        (json) => Car.fromJson(json as Map<String, dynamic>),
      ),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<SoldCar>> getSoldCar(int? id) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<SoldCar>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/sold-car/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<SoldCar>.fromJson(
      _result.data!,
      (json) => SoldCar.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Pagination<Returned>>> getReturned(
      {int? count = 100}) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'count': count};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Pagination<Returned>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/back-cars',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Pagination<Returned>>.fromJson(
      _result.data!,
      (json) => Pagination<Returned>.fromJson(
        json as Map<String, dynamic>,
        (json) => Returned.fromJson(json as Map<String, dynamic>),
      ),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<ReturnedDetail>> getReturnedCar(int? id) async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<ReturnedDetail>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/back-car/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<ReturnedDetail>.fromJson(
      _result.data!,
      (json) => ReturnedDetail.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  @override
  Stream<CustomResponse<Profile>> getDetail() async* {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CustomResponse<Profile>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v1/seller/detail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final _value = CustomResponse<Profile>.fromJson(
      _result.data!,
      (json) => Profile.fromJson(json as Map<String, dynamic>),
    );
    yield _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
