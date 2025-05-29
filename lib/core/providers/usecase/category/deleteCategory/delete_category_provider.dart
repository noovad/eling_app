import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/category.dart';
import 'package:eling_app/domain/usecases/category/deleteCategory/delete_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_category_provider.g.dart';

@riverpod
DeleteCategoryUseCase deleteCategoryUseCase(Ref ref) {
  return DeleteCategoryUseCaseImpl(
    logger: ref.watch(loggerProvider),
    categoryRepository: ref.watch(categoryRepositoryProvider),
  );
}
