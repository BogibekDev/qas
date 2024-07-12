import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequest {
  String password;

  @JsonKey(name: "phone_number")
  String phoneNumber;

  @JsonKey(name: "fcm_token")
  String fcmToken;
  @JsonKey(name: "device_type")
  String deviceType;

  LoginRequest(this.phoneNumber, this.password, this.fcmToken, this.deviceType);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
