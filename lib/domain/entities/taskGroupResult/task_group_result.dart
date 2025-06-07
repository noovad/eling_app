import 'package:eling/domain/entities/task/task.dart';
import 'package:eling/presentation/enum/task_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_group_result.freezed.dart';
part 'task_group_result.g.dart';

@freezed
class TaskGroupResultEntity with _$TaskGroupResultEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaskGroupResultEntity({
    @Default({}) Map<TaskType, List<TaskEntity>> tasksByType,
  }) = _TaskGroupResultEntity;

  factory TaskGroupResultEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupResultEntityFromJson(json);
}
