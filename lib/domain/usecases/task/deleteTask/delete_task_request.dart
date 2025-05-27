import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_task_request.freezed.dart';
part 'delete_task_request.g.dart';

@freezed
abstract class DeleteTaskRequest with _$DeleteTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeleteTaskRequest({required String id}) =
      _DeleteTaskRequest;

  factory DeleteTaskRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteTaskRequestFromJson(json);
}