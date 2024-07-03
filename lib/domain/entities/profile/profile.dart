import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile({
     this.fullName,
     this.phoneNumber,
     this.soldCarsCount,
     this.returnedCarsCount,
     this.rating,
  });

  @JsonKey(name: 'full_name')
  final String? fullName;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'sold_cars_count')
  final int? soldCarsCount;

  @JsonKey(name: 'returned_cars_count')
  final int? returnedCarsCount;
  final int? rating;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}
