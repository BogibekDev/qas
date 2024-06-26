import 'package:json_annotation/json_annotation.dart';

part 'return.g.dart';

@JsonSerializable()
class Return {
  @JsonKey(name: "car_id")
  final int? carId;
  final String? reason;

  Return(this.carId, this.reason);
  factory Return.fromJson(Map<String, dynamic> json) => _$ReturnFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnToJson(this);
}
