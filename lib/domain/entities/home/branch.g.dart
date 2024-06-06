// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'],
      curator: json['curator'] == null
          ? null
          : Curator.fromJson(json['curator'] as Map<String, dynamic>),
      cars: (json['cars'] as List<dynamic>?)
          ?.map((e) => Car.fromJson(e as Map<String, dynamic>))
          .toList(),
      soldCars: json['sold_cars'] as List<dynamic>?,
      backCars: json['back_cars'] as List<dynamic>?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'curator': instance.curator,
      'cars': instance.cars,
      'sold_cars': instance.soldCars,
      'back_cars': instance.backCars,
    };
