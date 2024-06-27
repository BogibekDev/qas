import 'package:json_annotation/json_annotation.dart';

import 'buyer.dart';

part 'sell_request.g.dart';

@JsonSerializable()
class SellRequest {
  @JsonKey(name: "car_id")
  final int? carId;
  final Buyer? buyer;

  final String? price;
  @JsonKey(name: "compensation_price")
  final String? compensationPrice;
  @JsonKey(name: "payment_type")
  final String? paymentType;

  @JsonKey(name: "pre_price")
  final String? prePrice;
  @JsonKey(name: "price_per_month")
  final String? pricePerMonth;
  final String? period;

  SellRequest(this.carId, this.buyer, this.price, this.compensationPrice,
      this.paymentType, this.prePrice, this.pricePerMonth, this.period);

  factory SellRequest.fromJson(Map<String, dynamic> json) =>
      _$SellRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SellRequestToJson(this);
}
