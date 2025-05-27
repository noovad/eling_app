import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling_app/domain/usecases/task/createTask/create_task_usecase.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks.dart';
import 'package:eling_app/domain/usecases/task/getCompletedTasks/get_completed_tasks_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'task_notifier.dart';

final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  return GetTasksUseCaseImpl(logger: Logger());
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  return GetCategoriesUseCaseImpl(logger: Logger());
});

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>((ref) {
  return CreateTaskUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});

final taskRepositoryProvider = Provider((ref) {
  return TaskRepository();
});

final getCompletedTasksProvider = Provider<GetCompletedTasksUseCaseImpl>((ref) {
  return GetCompletedTasksUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(
    ref.watch(getTasksUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
    ref.watch(getCompletedTasksProvider),
    ref.watch(createTaskUseCaseProvider),
  );
});
