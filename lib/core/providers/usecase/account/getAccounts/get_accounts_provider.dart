import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/account_repository_provider.dart';
import 'package:eling/domain/usecases/account/getAccounts/get_accounts_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_accounts_provider.g.dart';

@riverpod
GetAccountsUseCase getAccountsUseCase(Ref ref) {
  return GetAccountsUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(accountRepositoryProvider),
  );
}
