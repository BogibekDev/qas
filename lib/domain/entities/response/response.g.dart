// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomResponse<T> _$CustomResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CustomResponse<T>(
      json['success'] as bool,
      fromJsonT(json['data']),
      json['error'] == null
          ? null
          : Error.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomResponseToJson<T>(
  CustomResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'data': toJsonT(instance.data),
      'error': instance.error,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
      (json['statusCode'] as num?)?.toInt(),
      json['message'] as String?,
      (json['birth_year'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['detail'] as String?,
      json['code'] as String?,
    );

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'detail': instance.detail,
      'code': instance.code,
      'birth_year': instance.birthYear,
    };
