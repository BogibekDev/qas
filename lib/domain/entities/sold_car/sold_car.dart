import 'package:json_annotation/json_annotation.dart';

import '../home/car.dart';
import '../sell/buyer.dart';
import 'seller.dart';

part 'sold_car.g.dart';

@JsonSerializable()
class SoldCar {
  int? id;
  Buyer? buyer;
  Car? car;
  Seller? seller;
  String? price;
  @JsonKey(name: "remaining_price")
  String? remainingPrice;
  @JsonKey(name: "pre_price")
  String? prePrice;
  @JsonKey(name: "remaining_pre_price")
  String? remainingPrePrice;
  @JsonKey(name: "compensation_price")
  String? compensationPrice;
  @JsonKey(name: "payment_type")
  String? paymentType;
  int? period;
  @JsonKey(name: "price_per_month")
  String? pricePerMonth;
  List<String>? images;
  String? model;
  String? profit;
  String? contract;
  @JsonKey(name: "sold_date")
  String? soldDate;

  SoldCar(
    this.id,
    this.buyer,
    this.car,
    this.seller,
    this.price,
    this.remainingPrice,
    this.prePrice,
    this.remainingPrePrice,
    this.compensationPrice,
    this.paymentType,
    this.period,
    this.pricePerMonth,
    this.images,
    this.model,
    this.profit,
    this.contract,
    this.soldDate,
  );

  factory SoldCar.fromJson(Map<String, dynamic> json) =>
      _$SoldCarFromJson(json);

  Map<String, dynamic> toJson() => _$SoldCarToJson(this);
}
