import 'package:eling_app/domain/entities/dailyActivity/daily_activity.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/dailyActivity/get_daily_activities/get_daily_activities_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'summary_state.dart';
part 'summary_notifier.freezed.dart';

class SummaryNotifier extends StateNotifier<SummaryState> {
  final GetDailyActivitiesUseCase getDailyActivitiesUseCase;

  SummaryNotifier(this.getDailyActivitiesUseCase)
    : super(SummaryState.initial()) {
    getDailyActivities();
  }

  void getDailyActivities() async {
    final result = await getDailyActivitiesUseCase.execute(NoRequest());
    result.when(
      success: (dailyActivities) {
        state = state.copyWith(
          dailyActivities: Resource.success(dailyActivities),
        );
      },
      failure: (error) {
        state = state.copyWith(dailyActivities: Resource.failure(error));
      },
    );
  }
}
