// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: (json['id'] as num?)?.toInt(),
      model: json['model'] as String?,
      number: json['number'] as String?,
      year: (json['year'] as num?)?.toInt(),
      price: json['price'] as String?,
      profit: json['profit'] as String?,
      prePrice: json['pre_price'] as String?,
      fuelType: json['fuel_type'] as String?,
      type: json['type'] as String?,
      kilometer: (json['kilometer'] as num?)?.toInt(),
      color: json['color'] as String?,
      isPainted: json['is_painted'] as String?,
      description: json['description'] as String?,
      period: (json['period'] as num?)?.toInt(),
      pricePerMonth: json['price_per_month'] as String?,
      soldDate: json['sold_date'] as String?,
      similar: (json['similar'] as List<dynamic>?)
          ?.map((e) => Car.fromJson(e as Map<String, dynamic>))
          .toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      branch: json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      owner: json['owner'] == null
          ? null
          : Buyer.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'number': instance.number,
      'year': instance.year,
      'price': instance.price,
      'profit': instance.profit,
      'pre_price': instance.prePrice,
      'fuel_type': instance.fuelType,
      'type': instance.type,
      'kilometer': instance.kilometer,
      'color': instance.color,
      'is_painted': instance.isPainted,
      'description': instance.description,
      'period': instance.period,
      'price_per_month': instance.pricePerMonth,
      'sold_date': instance.soldDate,
      'similar': instance.similar,
      'images': instance.images,
      'owner': instance.owner,
      'branch': instance.branch,
    };
