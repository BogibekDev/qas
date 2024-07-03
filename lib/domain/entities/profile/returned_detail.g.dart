// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returned_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnedDetail _$ReturnedDetailFromJson(Map<String, dynamic> json) =>
    ReturnedDetail(
      id: (json['id'] as num?)?.toInt(),
      seller: json['seller'] == null
          ? null
          : Buyer.fromJson(json['seller'] as Map<String, dynamic>),
      acceptor: json['acceptor'] == null
          ? null
          : Buyer.fromJson(json['acceptor'] as Map<String, dynamic>),
      status: json['status'] as String?,
      reason: json['reason'] as String?,
      year: (json['year'] as num?)?.toInt(),
      model: json['model'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pdfLink: json['pdf_link'] as String?,
      returnedDate: json['returned_date'] as String?,
      price: json['price'] as String?,
      car: json['car'] == null
          ? null
          : Car.fromJson(json['car'] as Map<String, dynamic>),
      owner: json['owner'] == null
          ? null
          : Buyer.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnedDetailToJson(ReturnedDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seller': instance.seller,
      'acceptor': instance.acceptor,
      'status': instance.status,
      'reason': instance.reason,
      'year': instance.year,
      'model': instance.model,
      'images': instance.images,
      'returned_date': instance.returnedDate,
      'pdf_link': instance.pdfLink,
      'price': instance.price,
      'car': instance.car,
      'owner': instance.owner,
    };
