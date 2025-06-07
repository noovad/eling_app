import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/transaction_repository_provider.dart';
import 'package:eling/domain/usecases/transaction/getTransactions/get_transactions_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_transactions_provider.g.dart';

@riverpod
GetTransactionsUseCase getTransactionsUseCase(Ref ref) {
  return GetTransactionsUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionRepositoryProvider),
  );
}
