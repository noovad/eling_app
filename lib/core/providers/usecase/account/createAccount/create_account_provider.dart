import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/account_repository_provider.dart';
import 'package:eling/domain/usecases/account/createAccount/create_account_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_account_provider.g.dart';

@riverpod
CreateAccountUseCase createAccountUseCase(Ref ref) {
  return CreateAccountUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(accountRepositoryProvider),
  );
}
