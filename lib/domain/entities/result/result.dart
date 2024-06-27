import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/response/response.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.loading() = Loading;

  const factory Result.content(T content) = Content;

  const factory Result.error([Error? error]) = ErrorBody;
}