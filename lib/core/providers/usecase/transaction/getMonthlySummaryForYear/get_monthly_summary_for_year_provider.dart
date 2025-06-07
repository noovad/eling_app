import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/transaction.dart';
import 'package:eling/domain/usecases/transaction/getTransactionsByYear/get_monthly_summary_for_year_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_monthly_summary_for_year_provider.g.dart';

@riverpod
GetMonthlySummaryForYearUseCase getMonthlySummaryForYearUseCase(Ref ref) {
  return GetMonthlySummaryForYearUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionRepositoryProvider),
  );
}
