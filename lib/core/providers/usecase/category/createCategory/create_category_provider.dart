import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/category.dart';
import 'package:eling_app/domain/usecases/category/createCategory/create_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_category_provider.g.dart';

@riverpod
CreateCategoryUseCase createCategoryUseCase(Ref ref) {
  return CreateCategoryUseCaseImpl(logger: ref.watch(loggerProvider), categoryRepository: ref.watch(categoryRepositoryProvider));
}