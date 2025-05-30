import 'package:eling_app/core/providers/logger_provider.dart';
import 'package:eling_app/core/providers/repository/task.dart';
import 'package:eling_app/domain/usecases/dailyActivity/getDailyActivities/get_daily_activities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_daily_activities_provider.g.dart';

@riverpod
GetDailyActivitiesUseCase getDailyActivitiesUseCase(Ref ref) {
  return GetDailyActivitiesUseCaseImpl(
    logger: ref.watch(loggerProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
}
