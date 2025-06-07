import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/account_repository_provider.dart';
import 'package:eling/domain/usecases/account/deleteAccount/delete_account_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account_provider.g.dart';

@riverpod
DeleteAccountUseCase deleteAccountUseCase(Ref ref) {
  return DeleteAccountUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(accountRepositoryProvider),
  );
}
