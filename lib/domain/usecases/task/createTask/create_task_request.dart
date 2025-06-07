import 'package:eling/domain/entities/task/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_task_request.freezed.dart';
part 'create_task_request.g.dart';

@freezed
abstract class CreateTaskRequest with _$CreateTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateTaskRequest({required TaskEntity task}) =
      _CreateTaskRequest;

  factory CreateTaskRequest.fromJson(Map<String, Object?> json) =>
      _$CreateTaskRequestFromJson(json);
}
