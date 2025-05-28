import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/recurring_task.dart';
import 'package:eling_app/domain/usecases/recurringTask/getRecurringTasks/get_recurring_tasks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_recurring_tasks_provider.g.dart';

@riverpod
GetRecurringTasksUseCase getRecurringTasksUseCase(Ref ref) {
  return GetRecurringTasksUseCaseImpl(
    logger: ref.watch(loggerProvider),
    recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
  );
}
