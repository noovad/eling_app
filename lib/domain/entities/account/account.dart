import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

enum AccountType { balance, saving }

@freezed
class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    required String id,
    required String title,
    required AccountType type,
    double? balance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AccountEntity;

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);
}
