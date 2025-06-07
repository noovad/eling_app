import 'package:eling/core/providers/logger_provider.dart';
import 'package:eling/core/providers/repository/recurring_task.dart';
import 'package:eling/domain/usecases/recurringTask/updateRecurringTask/update_recurring_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_recurring_task_provider.g.dart';

@riverpod
UpdateRecurringTaskUseCase updateRecurringTaskUseCase(Ref ref) {
  return UpdateRecurringTaskUseCaseImpl(
    logger: ref.watch(loggerProvider),
    recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider),
  );
}
