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
    @Default('') String? note,
    required DateTime date,
    @Default('') String? time,
    @Default('') String? category,
    @Default(false) bool? isDone,
  }) = _TaskEntity;

  factory TaskEntity.fromJson(Map<String, Object?> json) =>
      _$TaskEntityFromJson(json);
}
