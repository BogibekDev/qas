import 'package:freezed_annotation/freezed_annotation.dart';

part 'curator.g.dart';

@JsonSerializable()
class Curator {
  Curator({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.phoneNumber,
    required this.branch,
    required this.role,
    required this.password,
    required this.soldCarsCount,
    required this.soldCars,
    required this.backCars,
  });

  final int? id;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'middle_name')
  final String? middleName;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final int? branch;
  final String? role;
  final String? password;

  @JsonKey(name: 'sold_cars_count')
  final int? soldCarsCount;

  @JsonKey(name: 'sold_cars')
  final List<dynamic>? soldCars;

  @JsonKey(name: 'back_cars')
  final List<dynamic>? backCars;

  factory Curator.fromJson(Map<String, dynamic> json) => _$CuratorFromJson(json);

  Map<String, dynamic> toJson() => _$CuratorToJson(this);

}