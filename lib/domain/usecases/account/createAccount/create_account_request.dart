import 'package:eling_app/domain/entities/account/account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_account_request.freezed.dart';
part 'create_account_request.g.dart';

@freezed
abstract class CreateAccountRequest with _$CreateAccountRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateAccountRequest({required AccountEntity account}) =
      _CreateAccountRequest;

  factory CreateAccountRequest.fromJson(Map<String, Object?> json) =>
      _$CreateAccountRequestFromJson(json);
}
