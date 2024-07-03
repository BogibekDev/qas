import 'package:json_annotation/json_annotation.dart';

import '../home/car.dart';
import '../sell/buyer.dart';

part 'returned_detail.g.dart';

@JsonSerializable()
class ReturnedDetail {
  ReturnedDetail({
     this.id,
     this.seller,
     this.acceptor,
     this.status,
     this.reason,
     this.year,
     this.model,
     this.images,
     this.pdfLink,
     this.returnedDate,
     this.price,
     this.car,
     this.owner,
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
  @JsonKey(name: 'pdf_link')
  final String? pdfLink;
  final String? price;
  final Car? car;
  final Buyer? owner;

  factory ReturnedDetail.fromJson(Map<String, dynamic> json) =>
      _$ReturnedDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedDetailToJson(this);
}
