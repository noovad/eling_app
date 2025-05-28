import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_categories_provider.g.dart';

@riverpod
GetCategoriesUseCase getCategoriesUseCase(Ref ref) {
  return GetCategoriesUseCaseImpl(logger: ref.watch(loggerProvider));
}