import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/task.dart';
import 'package:eling_app/domain/usecases/task/updateStatusTask/update_status_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_status_task_provider.g.dart';

@riverpod
UpdateStatusTaskUseCase updateStatusTaskUseCase(Ref ref) {
  return UpdateStatusTaskUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
}
