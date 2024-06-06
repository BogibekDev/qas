// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      middleName: json['middle_name'] as String?,
      birthYear: json['birth_year'] as String?,
      passport: json['passport'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phone_number'] as String?,
      extraPhoneNumber: json['extra_phone_number'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
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
