import 'package:freezed_annotation/freezed_annotation.dart';


import 'car.dart';
import 'curator.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
  Branch({
    required this.id,
    required this.title,
    required this.image,
    required this.curator,
    required this.cars,
    required this.soldCars,
    required this.backCars,
  });

  final int? id;
  final String? title;
  final dynamic image;
  final Curator? curator;
  final List<Car>? cars;

  @JsonKey(name: 'sold_cars')
  final List<dynamic>? soldCars;

  @JsonKey(name: 'back_cars')
  final List<dynamic>? backCars;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);

}