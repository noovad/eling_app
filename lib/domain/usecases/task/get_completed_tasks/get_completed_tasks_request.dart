import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_completed_tasks_request.freezed.dart';
part 'get_completed_tasks_request.g.dart';

@freezed
abstract class GetCompletedTasksRequest with _$GetCompletedTasksRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetCompletedTasksRequest({
    required int month,
    required int year,
  }) = _GetCompletedTasksRequest;

  factory GetCompletedTasksRequest.fromJson(Map<String, Object?> json) =>
      _$GetCompletedTasksRequestFromJson(json);
}
