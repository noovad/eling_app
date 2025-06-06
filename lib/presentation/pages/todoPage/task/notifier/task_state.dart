part of 'task_notifier.dart';

@freezed
abstract class TaskState with _$TaskState {
  const factory TaskState({
    // Task
    @Default(Resource.initial()) Resource<TaskGroupResultEntity> todayTask,
    @Default(Resource.initial()) Resource<TaskGroupResultEntity> upcomingTask,
    @Default(Resource.initial())
    Resource<RecurringTaskGroupResultEntity> recurringTask,
    @Default(TitleInput.pure()) TitleInput title,
    @Default(DateInput.pure()) DateInput date,
    @Default(false) bool isValid,
    String? selectedCategory,
    String? note,
    String? time,

    // Result
    @Default(Resource.initial()) Resource<String> saveResult,
    @Default(Resource.initial()) Resource<String> updateResult,
    @Default(Resource.initial()) Resource<String> updateStatusResult,
    @Default(Resource.initial()) Resource<String> deleteResult,

    // Category
    @Default(Resource.initial()) Resource<List<CategoryEntity>> dailyCategories,
    @Default(Resource.initial())
    Resource<List<CategoryEntity>> productivityCategories,
    @Default(Resource.initial()) Resource<List<CategoryEntity>> noteCategories,
    @Default(CategoryTitle.pure()) CategoryTitle categoryTitle,
    @Default(false) bool isValidCategory,

    // Completed Tasks
    @Default(Resource.initial()) Resource<List<TaskEntity>> completedTasks,
    required DateTime dateFilter,
  }) = _TaskState;

  factory TaskState.initial() => TaskState(dateFilter: DateTime.now());
}
