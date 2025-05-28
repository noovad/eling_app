import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/task.dart';
import 'package:eling_app/domain/usecases/task/getCompletedTasks/get_completed_tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_completed_tasks_provider.g.dart';

@riverpod
GetCompletedTasksUseCase getCompletedTasksUseCase(Ref ref) {
  return GetCompletedTasksUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
}
