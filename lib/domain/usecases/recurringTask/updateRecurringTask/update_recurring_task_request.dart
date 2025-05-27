import 'package:eling_app/domain/entities/recurringTask/recurring_task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_recurring_task_request.freezed.dart';
part 'update_recurring_task_request.g.dart';

@freezed
abstract class UpdateRecurringTaskRequest with _$UpdateRecurringTaskRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateRecurringTaskRequest({required RecurringTaskEntity recurringTask}) =
      _UpdateRecurringTaskRequest;

  factory UpdateRecurringTaskRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateRecurringTaskRequestFromJson(json);
}