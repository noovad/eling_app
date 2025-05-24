part of 'task_notifier.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState({
    required Resource<TaskGroupResultEntity> todayTask,
    required Resource<TaskGroupResultEntity> upcomingTask,
    required Resource<TaskGroupResultEntity> recurringTask,
    required Resource<List<CategoryEntity>> dailyCategories,
    required Resource<List<CategoryEntity>> productivityCategories,
    @Default(TitleInput.pure()) TitleInput title,
    @Default(DateInput.pure()) DateInput date,
    @Default(false) bool isvalid,
    String? selectedCategory,
    String? note,
    String? time,
  }) = _TaskState;

  factory TaskState.initial() => TaskState(
    todayTask: Resource.initial(),
    upcomingTask: Resource.initial(),
    recurringTask: Resource.initial(),
    dailyCategories: Resource.initial(),
    productivityCategories: Resource.initial(),
  );
}
