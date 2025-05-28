import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/recurring_task.dart';
import 'package:eling_app/domain/usecases/recurringTask/deleteRecurringTask/delete_recurring_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_recurring_task_provider.g.dart';

@riverpod
DeleteRecurringTaskUseCase deleteRecurringTaskUseCase(Ref ref) {
  return DeleteRecurringTaskUseCaseImpl(
    logger: ref.watch(loggerProvider),
    recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
  );
}
