part of 'summary_notifier.dart';

@freezed
abstract class SummaryState with _$SummaryState {
  const factory SummaryState({
    @Default(Resource.initial())
    Resource<List<DailyActivityEntity>> dailyActivities,
    required DateTime date,
  }) = _SummaryState;

  factory SummaryState.initial() => SummaryState(date: DateTime.now());
}
