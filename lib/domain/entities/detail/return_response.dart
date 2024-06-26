import 'package:json_annotation/json_annotation.dart';

part 'return_response.g.dart';

@JsonSerializable()
class ReturnResponse {
  @JsonKey(name: "pdf_link")
  final String? pdfLink;

  ReturnResponse(this.pdfLink);
  factory ReturnResponse.fromJson(Map<String, dynamic> json) =>
      _$ReturnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnResponseToJson(this);
}
