import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/transaction_repository_provider.dart';
import 'package:eling_app/domain/usecases/transaction/createTransaction/create_transaction_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transaction_provider.g.dart';

@riverpod
CreateTransactionUseCase createTransactionUseCase(
  Ref ref,
) {
  return CreateTransactionUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionRepositoryProvider),
  );
}
