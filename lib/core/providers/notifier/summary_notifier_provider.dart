import 'package:eling_app/core/providers/usecase/dailyactivities/getDailyActivities/get_daily_activities_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/summary/notifier/summary_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final summaryNotifierProvider =
    StateNotifierProvider<SummaryNotifier, SummaryState>((ref) {
      return SummaryNotifier(ref.watch(getDailyActivitiesUseCaseProvider));
    });
