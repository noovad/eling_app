import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/category.dart';
import 'package:eling/domain/usecases/category/getCategories/get_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_categories_provider.g.dart';

@riverpod
GetCategoriesUseCase getCategoriesUseCase(Ref ref) {
  return GetCategoriesUseCaseImpl(
    logger: ref.watch(loggerProvider),
    categoryRepository: ref.watch(categoryRepositoryProvider),
  );
}
