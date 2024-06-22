import 'package:json_annotation/json_annotation.dart';

part 'buyer.g.dart';

@JsonSerializable()
class Buyer {
  Buyer(
    this.id,
    this.firstName,
    this.lastName,
    this.middleName,
    this.birthYear,
    this.passport,
    this.address,
    this.phoneNumber,
    this.extraPhoneNumber,
  );

  final int? id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'birth_year')
  final String? birthYear;
  final String? passport;
  final String? address;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'extra_phone_number')
  final String? extraPhoneNumber;

  factory Buyer.fromJson(Map<String, dynamic> json) => _$BuyerFromJson(json);

  Map<String, dynamic> toJson() => _$BuyerToJson(this);
}
