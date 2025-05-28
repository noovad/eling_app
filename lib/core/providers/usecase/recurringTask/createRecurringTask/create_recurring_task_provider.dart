import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/recurring_task.dart';
import 'package:eling_app/domain/usecases/recurringTask/createRecurringTask/create_recurring_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_recurring_task_provider.g.dart';

@riverpod
CreateRecurringTaskUseCase createRecurringTaskUseCase(Ref ref) {
  return CreateRecurringTaskUseCaseImpl(logger: ref.watch(loggerProvider), recurringTaskRepository: ref.watch(recurringTaskRepositoryProvider));
}