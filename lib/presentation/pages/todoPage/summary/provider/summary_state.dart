part of 'summary_notifier.dart';

@freezed
abstract class SummaryState with _$SummaryState {
  const factory SummaryState({
    required Resource<List<DailyActivityEntity>> dailyActivities,
  }) = _SummaryState;

  factory SummaryState.initial() =>
      SummaryState(dailyActivities: Resource.initial());
}
