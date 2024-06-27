// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sell_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellRequest _$SellRequestFromJson(Map<String, dynamic> json) => SellRequest(
      (json['car_id'] as num?)?.toInt(),
      json['buyer'] == null
          ? null
          : Buyer.fromJson(json['buyer'] as Map<String, dynamic>),
      json['price'] as String?,
      json['compensation_price'] as String?,
      json['payment_type'] as String?,
      json['pre_price'] as String?,
      json['price_per_month'] as String?,
      json['period'] as String?,
    );

Map<String, dynamic> _$SellRequestToJson(SellRequest instance) =>
    <String, dynamic>{
      'car_id': instance.carId,
      'buyer': instance.buyer,
      'price': instance.price,
      'compensation_price': instance.compensationPrice,
      'payment_type': instance.paymentType,
      'pre_price': instance.prePrice,
      'price_per_month': instance.pricePerMonth,
      'period': instance.period,
    };
