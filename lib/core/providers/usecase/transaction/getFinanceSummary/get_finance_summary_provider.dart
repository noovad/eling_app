import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/transaction_repository_provider.dart';
import 'package:eling_app/domain/usecases/transaction/getFinanceSummary/get_finance_summary_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_finance_summary_provider.g.dart';

@riverpod
GetFinanceSummaryUseCase getFinanceSummaryUseCase(
  Ref ref,
) {
  return GetFinanceSummaryUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionRepositoryProvider),
  );
}
