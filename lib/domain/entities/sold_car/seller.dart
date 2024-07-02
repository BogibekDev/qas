import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "middle_name")
  String? middleName;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  int? curator;
  String? password;

  Seller(this.id, this.firstName, this.lastName, this.middleName,
      this.phoneNumber, this.curator, this.password);

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

  Map<String, dynamic> toJson() => _$SellerToJson(this);
}
