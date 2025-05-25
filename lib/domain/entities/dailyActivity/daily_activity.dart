import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_activity.freezed.dart';
part 'daily_activity.g.dart';

@freezed
abstract class DailyActivityEntity with _$DailyActivityEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DailyActivityEntity({
    required DateTime date,
    required int sholat,
    required bool gym,
    required bool cardio,
    required bool coding,
    required int amount,
    required bool calorieControlled,
  }) = _DailyActivityEntity;

  factory DailyActivityEntity.fromJson(Map<String, Object?> json) =>
      _$DailyActivityEntityFromJson(json);
}
