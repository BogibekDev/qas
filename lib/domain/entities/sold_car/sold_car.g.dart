// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sold_car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoldCar _$SoldCarFromJson(Map<String, dynamic> json) => SoldCar(
      (json['id'] as num?)?.toInt(),
      json['buyer'] == null
          ? null
          : Buyer.fromJson(json['buyer'] as Map<String, dynamic>),
      json['car'] == null
          ? null
          : Car.fromJson(json['car'] as Map<String, dynamic>),
      json['seller'] == null
          ? null
          : Seller.fromJson(json['seller'] as Map<String, dynamic>),
      json['price'] as String?,
      json['remaining_price'] as String?,
      json['pre_price'] as String?,
      json['remaining_pre_price'] as String?,
      json['compensation_price'] as String?,
      json['payment_type'] as String?,
      (json['period'] as num?)?.toInt(),
      json['price_per_month'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['model'] as String?,
      json['profit'] as String?,
      json['description'] as String?,
      json['contract'] as String?,
      json['sold_date'] as String?,
    );

Map<String, dynamic> _$SoldCarToJson(SoldCar instance) => <String, dynamic>{
      'id': instance.id,
      'buyer': instance.buyer,
      'car': instance.car,
      'seller': instance.seller,
      'price': instance.price,
      'remaining_price': instance.remainingPrice,
      'pre_price': instance.prePrice,
      'remaining_pre_price': instance.remainingPrePrice,
      'compensation_price': instance.compensationPrice,
      'payment_type': instance.paymentType,
      'period': instance.period,
      'price_per_month': instance.pricePerMonth,
      'images': instance.images,
      'model': instance.model,
      'profit': instance.profit,
      'contract': instance.contract,
      'description': instance.description,
      'sold_date': instance.soldDate,
    };
