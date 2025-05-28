import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/task.dart';
import 'package:eling_app/domain/usecases/task/createTask/create_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_task_provider.g.dart';

@riverpod
CreateTaskUseCase createTaskUseCase(Ref ref) {
  return CreateTaskUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
}
