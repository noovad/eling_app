import 'package:eling/presentation/enum/task_schedule_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tasks_request.freezed.dart';
part 'get_tasks_request.g.dart';

@freezed
abstract class GetTasksRequest with _$GetTasksRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetTasksRequest({required TaskScheduleType type}) =
      _GetTasksRequest;

  factory GetTasksRequest.fromJson(Map<String, Object?> json) =>
      _$GetTasksRequestFromJson(json);
}
