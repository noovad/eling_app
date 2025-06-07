import 'package:eling/core/enum/transaction_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_transactions_request.freezed.dart';
part 'get_transactions_request.g.dart';

@freezed
abstract class GetTransactionsRequest with _$GetTransactionsRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetTransactionsRequest({
    required int month,
    required int year,
    TransactionType? type,
  }) = _GetTransactionsRequest;

  factory GetTransactionsRequest.fromJson(Map<String, Object?> json) =>
      _$GetTransactionsRequestFromJson(json);
}
