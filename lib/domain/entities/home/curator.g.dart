// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Curator _$CuratorFromJson(Map<String, dynamic> json) => Curator(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      middleName: json['middle_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      branch: (json['branch'] as num?)?.toInt(),
      role: json['role'] as String?,
      password: json['password'] as String?,
      soldCarsCount: (json['sold_cars_count'] as num?)?.toInt(),
      soldCars: json['sold_cars'] as List<dynamic>?,
      backCars: json['back_cars'] as List<dynamic>?,
    );

Map<String, dynamic> _$CuratorToJson(Curator instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'phone_number': instance.phoneNumber,
      'branch': instance.branch,
      'role': instance.role,
      'password': instance.password,
      'sold_cars_count': instance.soldCarsCount,
      'sold_cars': instance.soldCars,
      'back_cars': instance.backCars,
    };
