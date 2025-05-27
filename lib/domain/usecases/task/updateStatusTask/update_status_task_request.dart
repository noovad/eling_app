import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_status_task_request.freezed.dart';
part 'update_status_task_request.g.dart';

@freezed
abstract class UpdateStatusTaskRequest with _$UpdateStatusTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateStatusTaskRequest({
    required String id,
    required bool status,
  }) = _UpdateStatusTaskRequest;

  factory UpdateStatusTaskRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateStatusTaskRequestFromJson(json);
}
