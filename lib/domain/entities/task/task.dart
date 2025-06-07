import 'package:eling/core/utils/data_type_converter.dart';
import 'package:eling/presentation/enum/task_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class TaskEntity with _$TaskEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaskEntity({
    required String id,
    required String title,
    @DateOnlyConverter() required DateTime date,
    required TaskType type,
    String? note,
    String? time,
    String? category,
    @BoolToIntConverter() @Default(false) bool? isDone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TaskEntity;

  factory TaskEntity.fromJson(Map<String, Object?> json) =>
      _$TaskEntityFromJson(json);
}
