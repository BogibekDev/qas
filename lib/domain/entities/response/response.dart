import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CustomResponse<T> {
  final bool success;
  final T data;
  final Error? error;

  CustomResponse(this.success, this.data, this.error);

  factory CustomResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CustomResponseFromJson(json,fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$CustomResponseToJson(this, toJsonT);
}

@JsonSerializable()
class Error {
  final String message;

  Error(this.message);

  factory Error.fromJson(Map<String, dynamic> json) =>
      _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
