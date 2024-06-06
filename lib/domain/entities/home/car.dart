import 'package:freezed_annotation/freezed_annotation.dart';

import 'branch.dart';
import 'owner.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  Car({
    required this.id,
    required this.model,
    required this.number,
    required this.year,
    required this.camePrice,
    required this.price,
    required this.prePrice,
    required this.fuelType,
    required this.type,
    required this.kilometer,
    required this.color,
    required this.isPainted,
    required this.description,
    required this.owner,
    required this.period,
    required this.pricePerMonth,
    required this.similar,
    required this.contract,
    required this.deed,
    required this.images,
    required this.branch,
  });

  final int? id;
  final String? model;
  final String? number;
  final int? year;

  @JsonKey(name: 'came_price')
  final String? camePrice;
  final String? price;

  @JsonKey(name: 'pre_price')
  final String? prePrice;

  @JsonKey(name: 'fuel_type')
  final String? fuelType;
  final String? type;
  final int? kilometer;
  final String? color;

  @JsonKey(name: 'is_painted')
  final String? isPainted;
  final String? description;
  final Owner? owner;
  final int? period;

  @JsonKey(name: 'price_per_month')
  final String? pricePerMonth;
  final List<Car>? similar;
  final String? contract;
  final dynamic deed;
  final List<String>? images;
  final Branch? branch;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);

}