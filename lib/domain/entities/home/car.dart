import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qas/domain/entities/detail/branch.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  Car({
     this.id,
     this.model,
     this.number,
     this.year,
     this.price,
     this.prePrice,
     this.fuelType,
     this.type,
     this.kilometer,
     this.color,
     this.isPainted,
     this.description,
     this.period,
     this.pricePerMonth,
     this.similar,
     this.images,
     this.branch,
  });

  final int? id;
  final String? model;
  final String? number;
  final int? year;
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
  final int? period;

  @JsonKey(name: 'price_per_month')
  final String? pricePerMonth;
  final List<Car>? similar;
  final List<String>? images;
  final Branch? branch;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);

}