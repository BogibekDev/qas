import 'package:json_annotation/json_annotation.dart';

part 'sell_response.g.dart';

@JsonSerializable()
class SellResponse {
  final String? contract;

  SellResponse(this.contract);

  factory SellResponse.fromJson(Map<String, dynamic> json) =>
      _$SellResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SellResponseToJson(this);
}
