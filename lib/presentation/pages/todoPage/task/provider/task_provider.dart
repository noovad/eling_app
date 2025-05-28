import 'package:eling_app/data/repositories/recurring_task_repository.dart';
import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling_app/domain/usecases/recurringTask/createRecurringTask/create_recurring_task.dart';
import 'package:eling_app/domain/usecases/recurringTask/deleteRecurringTask/delete_recurring_task.dart';
import 'package:eling_app/domain/usecases/recurringTask/getRecurringTasks/get_recurring_tasks.dart';
import 'package:eling_app/domain/usecases/recurringTask/updateRecurringTask/update_recurring_task.dart';
import 'package:eling_app/domain/usecases/task/createTask/create_task.dart';
import 'package:eling_app/domain/usecases/task/deleteTask/delete_task.dart';
import 'package:eling_app/domain/usecases/task/getTasks/get_tasks.dart';
import 'package:eling_app/domain/usecases/task/getCompletedTasks/get_completed_tasks.dart';
import 'package:eling_app/domain/usecases/task/updateStatusTask/update_status_task.dart';
import 'package:eling_app/domain/usecases/task/updateTask/update_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'task_notifier.dart';

final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  return GetTasksUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
    recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
  );
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

final updateTaskUseCaseProvider = Provider<UpdateTaskUseCase>((ref) {
  return UpdateTaskUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});
final updateTaskStatusUseCaseProvider = Provider<UpdateStatusTaskUseCase>((
  ref,
) {
  return UpdateStatusTaskUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});
final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  return DeleteTaskUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});

final taskRepositoryProvider = Provider((ref) {
  return TaskRepository();
});

final recurringTaskRepositoryProvider = Provider((ref) {
  return RecurringTaskRepository();
});

final getCompletedTasksProvider = Provider<GetCompletedTasksUseCaseImpl>((ref) {
  return GetCompletedTasksUseCaseImpl(
    logger: Logger(),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});

final getRecurringTasksUseCaseProvider = Provider<GetRecurringTasksUseCase>((
  ref,
) {
  return GetRecurringTasksUseCaseImpl(
    logger: Logger(),
    recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
  );
});
final createRecurringTaskUseCaseProvider = Provider<CreateRecurringTaskUseCase>(
  (ref) {
    return CreateRecurringTaskUseCaseImpl(
      logger: Logger(),
      recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
    );
  },
);
final updateRecurringTaskUseCaseProvider = Provider<UpdateRecurringTaskUseCase>(
  (ref) {
    return UpdateRecurringTaskUseCaseImpl(
      logger: Logger(),
      recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
    );
  },
);
final deleteRecurringTaskUseCaseProvider = Provider<DeleteRecurringTaskUseCase>(
  (ref) {
    return DeleteRecurringTaskUseCaseImpl(
      logger: Logger(),
      recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
    );
  },
);

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(
    ref.watch(getTasksUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
    ref.watch(getCompletedTasksProvider),
    ref.watch(createTaskUseCaseProvider),
    ref.watch(updateTaskUseCaseProvider),
    ref.watch(updateTaskStatusUseCaseProvider),
    ref.watch(deleteTaskUseCaseProvider),
    ref.watch(getRecurringTasksUseCaseProvider),
    ref.watch(createRecurringTaskUseCaseProvider),
    ref.watch(updateRecurringTaskUseCaseProvider),
    ref.watch(deleteRecurringTaskUseCaseProvider),
  );
});
