// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returned.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Returned _$ReturnedFromJson(Map<String, dynamic> json) => Returned(
      id: (json['id'] as num?)?.toInt(),
      seller: json['seller'] as String?,
      acceptor: json['acceptor'] as String?,
      status: json['status'] as String?,
      reason: json['reason'] as String?,
      year: (json['year'] as num?)?.toInt(),
      model: json['model'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      returnedDate: json['returned_date'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$ReturnedToJson(Returned instance) => <String, dynamic>{
      'id': instance.id,
      'seller': instance.seller,
      'acceptor': instance.acceptor,
      'status': instance.status,
      'reason': instance.reason,
      'year': instance.year,
      'model': instance.model,
      'images': instance.images,
      'returned_date': instance.returnedDate,
      'price': instance.price,
    };
