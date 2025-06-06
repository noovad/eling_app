import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_transaction_request.freezed.dart';
part 'delete_transaction_request.g.dart';

@freezed
abstract class DeleteTransactionRequest with _$DeleteTransactionRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeleteTransactionRequest({required String id}) =
      _DeleteTransactionRequest;

  factory DeleteTransactionRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteTransactionRequestFromJson(json);
}
