// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Return _$ReturnFromJson(Map<String, dynamic> json) => Return(
      (json['car_id'] as num?)?.toInt(),
      json['reason'] as String?,
    );

Map<String, dynamic> _$ReturnToJson(Return instance) => <String, dynamic>{
      'car_id': instance.carId,
      'reason': instance.reason,
    };
