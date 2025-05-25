part of '../task_notifier.dart';

mixin TaskCRUDMixin on StateNotifier<TaskState> {
  GetTasksUseCase get getTasksUseCase;

  void saveTask() async {
    final title = state.title.value;
    final date = state.date.value;
    final time = state.time ?? '';
    final category = state.selectedCategory ?? '';
    final note = state.note ?? '';
    debugPrint(
      'Saving task with title: $title, date: $date, time: $time, category: $category, note: $note',
    );
  }

  void deleteTask(String taskId) async {
    debugPrint('Deleting task with ID: $taskId');
  }

  void updateStatus(String taskId, bool status) async {
    debugPrint('Updating task with ID: $taskId from status: $status');
  }

  void updateTask() async {
    final title = state.title.value;
    final date = state.date.value;
    final time = state.time ?? '';
    final category = state.selectedCategory ?? '';
    final note = state.note ?? '';
    debugPrint(
      'Updating task with title: $title, date: $date, time: $time, category: $category, note: $note',
    );
  }

  void getTasks(TaskScheduleType taskTabsType) async {
    final result = await getTasksUseCase.execute(
      GetTasksRequest(type: taskTabsType),
    );
    result.when(
      success: (data) {
        switch (taskTabsType) {
          case TaskScheduleType.today:
            state = state.copyWith(todayTask: Resource.success(data));
            break;
          case TaskScheduleType.upcoming:
            state = state.copyWith(upcomingTask: Resource.success(data));
            break;
          case TaskScheduleType.recurring:
            state = state.copyWith(recurringTask: Resource.success(data));
            break;
        }
      },
      failure: (error) {
        switch (taskTabsType) {
          case TaskScheduleType.today:
            state = state.copyWith(todayTask: Resource.failure(error));
            break;
          case TaskScheduleType.upcoming:
            state = state.copyWith(upcomingTask: Resource.failure(error));
            break;
          case TaskScheduleType.recurring:
            state = state.copyWith(recurringTask: Resource.failure(error));
            break;
        }
      },
    );
  }
}
