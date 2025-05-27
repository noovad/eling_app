import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_recurring_task_request.freezed.dart';
part 'delete_recurring_task_request.g.dart';

@freezed
abstract class DeleteRecurringTaskRequest with _$DeleteRecurringTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeleteRecurringTaskRequest({required String id}) =
      _DeleteRecurringTaskRequest;

  factory DeleteRecurringTaskRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteRecurringTaskRequestFromJson(json);
}