import 'package:eling_app/domain/entities/dailyActivity/daily_activity.dart';
import 'package:eling_app/domain/usecases/dailyActivity/get_daily_activities/get_daily_activities_request.dart';
import 'package:eling_app/domain/usecases/dailyActivity/get_daily_activities/get_daily_activities_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'summary_state.dart';
part 'summary_notifier.freezed.dart';

class SummaryNotifier extends StateNotifier<SummaryState> {
  final GetDailyActivitiesUseCase getDailyActivitiesUseCase;

  SummaryNotifier(this.getDailyActivitiesUseCase)
    : super(SummaryState.initial());

  void getDailyActivities(int month, int year) async {
    Future.microtask(() {
      state = state.copyWith(dailyActivities: Resource.loading());
      state = state.copyWith(date: DateTime(year, month));
    });

    debugPrint(month.toString());
    debugPrint(year.toString());

    final result = await getDailyActivitiesUseCase.execute(
      GetDailyActivitiesRequest(month: month, year: year),
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
}
