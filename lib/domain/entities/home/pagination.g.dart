// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      (json['total'] as num?)?.toInt(),
      (json['next'] as num?)?.toInt(),
      (json['previous'] as num?)?.toInt(),
      (json['current'] as num?)?.toInt(),
      (json['results'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'next': instance.next,
      'previous': instance.previous,
      'current': instance.current,
      'results': instance.results?.map(toJsonT).toList(),
    };
