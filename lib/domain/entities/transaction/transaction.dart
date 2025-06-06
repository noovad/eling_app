import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionType { income, expense, savings, transfer }

@freezed
abstract class TransactionEntity with _$TransactionEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TransactionEntity({
    required String id,
    required TransactionType type,
    required String title,
    required DateTime date,
    required double amount,
    String? category,
    String? source,
    String? target,
    String? description,
  }) = _TransactionEntity;

  factory TransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionEntityFromJson(json);
}
