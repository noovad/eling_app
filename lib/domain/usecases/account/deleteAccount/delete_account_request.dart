import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_account_request.freezed.dart';
part 'delete_account_request.g.dart';

@freezed
abstract class DeleteAccountRequest with _$DeleteAccountRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeleteAccountRequest({required String id}) =
      _DeleteAccountRequest;

  factory DeleteAccountRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteAccountRequestFromJson(json);
}
