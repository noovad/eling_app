part of 'task_notifier.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState({
    required Resource<TaskGroupResultEntity> todayTask,
    required Resource<TaskGroupResultEntity> upcomingTask,
    required Resource<TaskGroupResultEntity> recurringTask,
  }) = _TaskState;

  factory TaskState.initial() => TaskState(
    todayTask: Resource.initial(),
    upcomingTask: Resource.initial(),
    recurringTask: Resource.initial(),
  );
}
