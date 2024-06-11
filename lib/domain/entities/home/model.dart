import 'package:json_annotation/json_annotation.dart';


part 'model.g.dart';
@JsonSerializable()
class Model {
  final int id;
  final String title;

  Model(this.id, this.title);
  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
