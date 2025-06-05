import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/transaction_category_repository_provider.dart';
import 'package:eling_app/domain/usecases/transaction_category/deleteCategory/delete_category_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_category_provider.g.dart';

@riverpod
DeleteCategoryUseCase deleteCategoryUseCase(Ref ref) {
  return DeleteCategoryUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionCategoryRepositoryProvider),
  );
}
