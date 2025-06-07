import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/transaction_category_repository_provider.dart';
import 'package:eling/domain/usecases/transaction_category/getCategories/get_categories_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_categories_provider.g.dart';

@riverpod
GetCategoriesUseCase getCategoriesUseCase(Ref ref) {
  return GetCategoriesUseCaseImpl(
    logger: ref.watch(loggerProvider),
    repository: ref.watch(transactionCategoryRepositoryProvider),
  );
}
