import 'package:eling_app/domain/entities/task/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_task_request.freezed.dart';
part 'update_task_request.g.dart';

@freezed
abstract class UpdateTaskRequest with _$UpdateTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateTaskRequest({required TaskEntity task}) =
      _UpdateTaskRequest;

  factory UpdateTaskRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateTaskRequestFromJson(json);
}