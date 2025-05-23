import 'package:eling_app/domain/usecases/task/getCategories/get_tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'task_notifier.dart';

final getTasksUseCaseProvider = Provider<GetTasksUseCase>((ref) {
  return GetTasksUseCaseImpl(logger: Logger());
});

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(ref.watch(getTasksUseCaseProvider));
});
