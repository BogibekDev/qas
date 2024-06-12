import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';
@JsonSerializable()
class Branch {
  final int? id;
  final String title;
  final String? image;

  Branch(this.id, this.title, this.image);

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);

}
