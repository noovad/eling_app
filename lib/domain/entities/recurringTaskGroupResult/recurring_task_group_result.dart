import 'package:eling/domain/entities/recurringTask/recurring_task.dart';
import 'package:eling/presentation/enum/task_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_task_group_result.freezed.dart';
part 'recurring_task_group_result.g.dart';

@freezed
abstract class RecurringTaskGroupResultEntity
    with _$RecurringTaskGroupResultEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RecurringTaskGroupResultEntity({
    @Default({}) Map<TaskType, List<RecurringTaskEntity>> tasksByType,
  }) = _RecurringTaskGroupResultEntity;

  factory RecurringTaskGroupResultEntity.fromJson(Map<String, Object?> json) =>
      _$RecurringTaskGroupResultEntityFromJson(json);
}
