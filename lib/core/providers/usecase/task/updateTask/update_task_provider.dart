import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/task.dart';
import 'package:eling/domain/usecases/task/updateTask/update_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_task_provider.g.dart';

@riverpod
UpdateTaskUseCase updateTaskUseCase(Ref ref) {
  return UpdateTaskUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
}
