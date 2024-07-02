import 'package:json_annotation/json_annotation.dart';

part 'returned.g.dart';

@JsonSerializable()
class Returned {
  Returned({
    this.id,
    this.seller,
    this.acceptor,
    this.status,
    this.reason,
    this.year,
    this.model,
    this.images,
    this.returnedDate,
    this.price,
  });

  final int? id;
  final String? seller;
  final String? acceptor;
  final String? status;
  final String? reason;
  final int? year;
  final String? model;
  final List<String>? images;

  @JsonKey(name: 'returned_date')
  final String? returnedDate;
  final String? price;

  factory Returned.fromJson(Map<String, dynamic> json) =>
      _$ReturnedFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedToJson(this);
}
