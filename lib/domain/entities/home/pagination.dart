import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Pagination<T> {
  int? total;
  int? next;
  int? previous;
  int? current;
  List<T>? results;

  Pagination(this.total, this.next, this.previous, this.current, this.results);

  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationToJson(this, toJsonT);
}
