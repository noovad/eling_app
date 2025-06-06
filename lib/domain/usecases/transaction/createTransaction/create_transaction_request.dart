import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_transaction_request.freezed.dart';
part 'create_transaction_request.g.dart';

@freezed
abstract class CreateTransactionRequest with _$CreateTransactionRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateTransactionRequest({
    required TransactionEntity transaction,
  }) = _CreateTransactionRequest;

  factory CreateTransactionRequest.fromJson(Map<String, Object?> json) =>
      _$CreateTransactionRequestFromJson(json);
}
