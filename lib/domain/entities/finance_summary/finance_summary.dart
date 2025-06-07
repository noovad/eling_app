import 'package:eling/domain/entities/detail_summary/detail_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance_summary.freezed.dart';
part 'finance_summary.g.dart';

@freezed
class FinanceSummaryEntity with _$FinanceSummaryEntity {
  const factory FinanceSummaryEntity({
    required double totalBalance,
    required double totalIncome,
    required double totalExpense,
    required double totalSavings,
    required List<DetailSummaryEntity> incomeSummaries,
    required List<DetailSummaryEntity> expenseSummaries,
    required int month,
    required int year,
  }) = _FinanceSummaryEntity;

  factory FinanceSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$FinanceSummaryEntityFromJson(json);
}
