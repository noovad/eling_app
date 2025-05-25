part of 'task_notifier.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState({
    // Task
    required Resource<TaskGroupResultEntity> todayTask,
    required Resource<TaskGroupResultEntity> upcomingTask,
    required Resource<TaskGroupResultEntity> recurringTask,
    @Default(TitleInput.pure()) TitleInput title,
    @Default(DateInput.pure()) DateInput date,
    @Default(false) bool isValid,
    String? selectedCategory,
    String? note,
    String? time,

    // Category
    required Resource<List<CategoryEntity>> dailyCategories,
    required Resource<List<CategoryEntity>> productivityCategories,
    required Resource<List<CategoryEntity>> noteCategories,
    @Default(CategoryTitle.pure()) CategoryTitle categoryTitle,
    @Default(false) bool isValidCategory,

    // Completed Tasks
    required Resource<List<TaskEntity>> completedTasks,
    required int monthFilter,
    required int yearFilter,
  }) = _TaskState;

  factory TaskState.initial() => TaskState(
    // Task
    todayTask: Resource.initial(),
    upcomingTask: Resource.initial(),
    recurringTask: Resource.initial(),

    // Category
    dailyCategories: Resource.initial(),
    productivityCategories: Resource.initial(),
    noteCategories: Resource.initial(),

    // Completed Tasks
    completedTasks: Resource.initial(),
    monthFilter: DateTime.now().month,
    yearFilter: DateTime.now().year,
  );
}
