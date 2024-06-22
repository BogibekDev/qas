// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Buyer _$BuyerFromJson(Map<String, dynamic> json) => Buyer(
      (json['id'] as num?)?.toInt(),
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['middle_name'] as String?,
      json['birth_year'] as String?,
      json['passport'] as String?,
      json['address'] as String?,
      json['phone_number'] as String?,
      json['extra_phone_number'] as String?,
    );

Map<String, dynamic> _$BuyerToJson(Buyer instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'birth_year': instance.birthYear,
      'passport': instance.passport,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
      'extra_phone_number': instance.extraPhoneNumber,
    };
