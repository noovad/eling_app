import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_accounts_request.freezed.dart';
part 'get_accounts_request.g.dart';

@freezed
abstract class GetAccountsRequest with _$GetAccountsRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetAccountsRequest() = _GetAccountsRequest;

  factory GetAccountsRequest.fromJson(Map<String, Object?> json) =>
      _$GetAccountsRequestFromJson(json);
}
