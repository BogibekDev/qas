import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class Owner {
  Owner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.birthYear,
    required this.passport,
    required this.address,
    required this.phoneNumber,
    required this.extraPhoneNumber,
  });

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

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);

}