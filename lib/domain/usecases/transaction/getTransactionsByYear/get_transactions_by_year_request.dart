import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_transactions_by_year_request.freezed.dart';
part 'get_transactions_by_year_request.g.dart';

@freezed
abstract class GetTransactionsByYearRequest
    with _$GetTransactionsByYearRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetTransactionsByYearRequest({required int year}) =
      _GetTransactionsByYearRequest;

  factory GetTransactionsByYearRequest.fromJson(Map<String, Object?> json) =>
      _$GetTransactionsByYearRequestFromJson(json);
}
