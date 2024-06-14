import 'package:json_annotation/json_annotation.dart';

part 'refresh.g.dart';

@JsonSerializable(createFactory: false)
class Refresh{
  final String refresh;
  Refresh(this.refresh);

  Map<String, dynamic> toJson() => _$RefreshToJson(this);

}