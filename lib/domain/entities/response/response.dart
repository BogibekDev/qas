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
  int? statusCode;
  String? message;
  final String? detail;
  final String? code;
  @JsonKey(name: "birth_year")
  final List<String>? birthYear;

  Error(this.statusCode,this.message, this.birthYear, this.detail, this.code);

  factory Error.fromJson(Map<String, dynamic> json) =>
      _$ErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorToJson(this);

  factory Error.empty()=>Error(null,null,null,null,null);
}
