// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      (json['id'] as num?)?.toInt(),
      json['title'] as String,
      json['image'] as String?,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };
