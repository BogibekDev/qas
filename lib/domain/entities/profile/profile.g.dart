// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      fullName: json['full_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      soldCarsCount: (json['sold_cars_count'] as num?)?.toInt(),
      returnedCarsCount: (json['returned_cars_count'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'sold_cars_count': instance.soldCarsCount,
      'returned_cars_count': instance.returnedCarsCount,
      'rating': instance.rating,
    };
