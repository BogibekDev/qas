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
      prePrice: json['pre_price'] as String?,
      fuelType: json['fuel_type'] as String?,
      type: json['type'] as String?,
      kilometer: (json['kilometer'] as num?)?.toInt(),
      color: json['color'] as String?,
      isPainted: json['is_painted'] as String?,
      description: json['description'] as String?,
      period: (json['period'] as num?)?.toInt(),
      pricePerMonth: json['price_per_month'] as String?,
      similar: (json['similar'] as List<dynamic>?)
          ?.map((e) => Car.fromJson(e as Map<String, dynamic>))
          .toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      branch: json['branch'] as String?,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'number': instance.number,
      'year': instance.year,
      'price': instance.price,
      'pre_price': instance.prePrice,
      'fuel_type': instance.fuelType,
      'type': instance.type,
      'kilometer': instance.kilometer,
      'color': instance.color,
      'is_painted': instance.isPainted,
      'description': instance.description,
      'period': instance.period,
      'price_per_month': instance.pricePerMonth,
      'similar': instance.similar,
      'images': instance.images,
      'branch': instance.branch,
    };
