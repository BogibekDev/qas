import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequest {
  String password;

  @JsonKey(name: "phone_number")
  String phoneNumber;

  LoginRequest(this.phoneNumber, this.password);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
