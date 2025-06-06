import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

enum AccountType { balance, saving }

@freezed
abstract class AccountEntity with _$AccountEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AccountEntity({
    required String id,
    required String name,
    required AccountType type,
    double? balance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AccountEntity;

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);
}
