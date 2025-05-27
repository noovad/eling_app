import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_daily_activities_request.freezed.dart';
part 'get_daily_activities_request.g.dart';

@freezed
abstract class GetDailyActivitiesRequest with _$GetDailyActivitiesRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetDailyActivitiesRequest({
    required int month,
    required int year,
  }) = _GetDailyActivitiesRequest;

  factory GetDailyActivitiesRequest.fromJson(Map<String, Object?> json) =>
      _$GetDailyActivitiesRequestFromJson(json);
}
