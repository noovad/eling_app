import 'package:eling/presentation/enum/task_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_task.freezed.dart';
part 'recurring_task.g.dart';

@freezed
abstract class RecurringTaskEntity with _$RecurringTaskEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RecurringTaskEntity({
    required String id,
    required String title,
    required TaskType type,
    @Default('') String? note,
    @Default('') String? time,
    @Default('') String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RecurringTaskEntity;

  factory RecurringTaskEntity.fromJson(Map<String, Object?> json) =>
      _$RecurringTaskEntityFromJson(json);
}
