import 'package:json_annotation/json_annotation.dart';

import '../home/car.dart';
import '../sell/buyer.dart';

part 'returned_detail.g.dart';

@JsonSerializable()
class ReturnedDetail {
  ReturnedDetail({
    required this.id,
    required this.seller,
    required this.acceptor,
    required this.status,
    required this.reason,
    required this.year,
    required this.model,
    required this.images,
    required this.returnedDate,
    required this.price,
    required this.car,
    required this.owner,
  });

  final int? id;
  final Buyer? seller;
  final Buyer? acceptor;
  final String? status;
  final String? reason;
  final int? year;
  final String? model;
  final List<String>? images;

  @JsonKey(name: 'returned_date')
  final String? returnedDate;
  final String? price;
  final Car? car;
  final Buyer? owner;

  factory ReturnedDetail.fromJson(Map<String, dynamic> json) =>
      _$ReturnedDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedDetailToJson(this);
}
