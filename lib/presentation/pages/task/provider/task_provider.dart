import 'package:eling_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'task_notifier.dart';

final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  return GetTasksUseCaseImpl(logger: Logger());
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  return GetCategoriesUseCaseImpl(logger: Logger());
});

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(
    ref.watch(getTasksUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
  );
});
