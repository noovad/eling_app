import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/transaction_repository_provider.dart';
import 'package:eling/domain/usecases/transaction/deleteTransaction/delete_transaction_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_transaction_provider.g.dart';

@riverpod
DeleteTransactionUseCase deleteTransactionUseCase(Ref ref) {
  return DeleteTransactionUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionRepositoryProvider),
  );
}
