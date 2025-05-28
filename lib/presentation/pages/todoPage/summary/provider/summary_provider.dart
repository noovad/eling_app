import 'package:eling_app/domain/usecases/dailyActivity/getDailyActivities/get_daily_activities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'summary_notifier.dart';

final getDailyActivitiesUseCaseProvider = Provider<GetDailyActivitiesUseCase>((
  ref,
) {
  return GetDailyActivitiesUseCaseImpl(logger: Logger());
});

final summaryProvider = StateNotifierProvider<SummaryNotifier, SummaryState>((
  ref,
) {
  return SummaryNotifier(ref.watch(getDailyActivitiesUseCaseProvider));
});
