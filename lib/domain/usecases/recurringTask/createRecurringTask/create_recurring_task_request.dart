import 'package:eling_app/domain/entities/recurringTask/recurring_task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_recurring_task_request.freezed.dart';
part 'create_recurring_task_request.g.dart';

@freezed
abstract class CreateRecurringTaskRequest with _$CreateRecurringTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateRecurringTaskRequest({required RecurringTaskEntity recurringTask}) =
      _CreateRecurringTaskRequest;

  factory CreateRecurringTaskRequest.fromJson(Map<String, Object?> json) =>
      _$CreateRecurringTaskRequestFromJson(json);
}