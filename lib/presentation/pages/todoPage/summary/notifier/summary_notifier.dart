import 'package:eling/domain/entities/dailyActivity/daily_activity.dart';
import 'package:eling/domain/usecases/dailyActivity/getDailyActivities/get_daily_activities_request.dart';
import 'package:eling/domain/usecases/dailyActivity/getDailyActivities/get_daily_activities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling/core/utils/resource.dart';

part 'summary_state.dart';
part 'summary_notifier.freezed.dart';

class SummaryNotifier extends StateNotifier<SummaryState> {
  final GetDailyActivitiesUseCase getDailyActivitiesUseCase;

  SummaryNotifier(this.getDailyActivitiesUseCase)
    : super(SummaryState.initial()) {
    getDailyActivities();
  }

  void getDailyActivities() async {
    final result = await getDailyActivitiesUseCase.execute(
      GetDailyActivitiesRequest(month: state.date.month, year: state.date.year),
    );
    result.when(
      success: (data) {
        state = state.copyWith(dailyActivities: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(dailyActivities: Resource.failure(error));
      },
    );
  }

  void dateChanged(DateTime date) {
    state = state.copyWith(date: date);
    getDailyActivities();
  }
}
