// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller(
      (json['id'] as num?)?.toInt(),
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['middle_name'] as String?,
      json['phone_number'] as String?,
      (json['curator'] as num?)?.toInt(),
      json['password'] as String?,
    );

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'phone_number': instance.phoneNumber,
      'curator': instance.curator,
      'password': instance.password,
    };
