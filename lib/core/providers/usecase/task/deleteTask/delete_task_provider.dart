import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/task.dart';
import 'package:eling_app/domain/usecases/task/deleteTask/delete_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_task_provider.g.dart';

@riverpod
DeleteTaskUseCase deleteTaskUseCase(Ref ref) {
  return DeleteTaskUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
}
