import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_category.freezed.dart';
part 'transaction_category.g.dart';

@freezed
class TransactionCategoryEntity with _$TransactionCategoryEntity {
  const factory TransactionCategoryEntity({
    required String id,
    required String name,
  }) = _TransactionCategoryEntity;

  factory TransactionCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionCategoryEntityFromJson(json);
}
