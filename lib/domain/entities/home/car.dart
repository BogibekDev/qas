import 'package:freezed_annotation/freezed_annotation.dart';

import '../detail/branch.dart';
import '../sell/buyer.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  Car({
    this.id,
    this.model,
    this.number,
    this.year,
    this.price,
    this.profit,
    this.prePrice,
    this.camePrice,
    this.fuelType,
    this.type,
    this.kilometer,
    this.color,
    this.isPainted,
    this.description,
    this.period,
    this.pricePerMonth,
    this.soldDate,
    this.similar,
    this.images,
    this.branch,
    this.owner,
    this.isNew,
  });

  final int? id;
  final String? model;
  final String? number;
  final int? year;
  final String? price;
  final String? profit;

  @JsonKey(name: 'pre_price')
  final String? prePrice;
  @JsonKey(name: 'came_price')
  final String? camePrice;

  @JsonKey(name: 'fuel_type')
  final String? fuelType;

  final String? type;
  final int? kilometer;
  final String? color;

  @JsonKey(name: 'is_painted')
  final String? isPainted;
  final String? description;
  final int? period;

  @JsonKey(name: 'price_per_month')
  final String? pricePerMonth;

  @JsonKey(name: 'sold_date')
  final String? soldDate;
  final List<Car>? similar;
  final List<String>? images;
  final Buyer? owner;
  final Branch? branch;
  @JsonKey(name: 'is_new')
  final bool? isNew;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}
