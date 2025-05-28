import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/recurring_task.dart';
import 'package:eling_app/core/providers/repository/task.dart';
import 'package:eling_app/domain/usecases/task/getTasks/get_tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_tasks_provider.g.dart';

@riverpod
GetTasksUseCase getTasksUseCase(Ref ref) {
  return GetTasksUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
    recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
  );
}
