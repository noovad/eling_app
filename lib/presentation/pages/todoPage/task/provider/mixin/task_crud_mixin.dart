part of '../task_notifier.dart';

mixin TaskCRUDMixin on StateNotifier<TaskState> {
  GetTasksUseCase get getTasksUseCase;
  CreateTaskUseCase get createTaskUseCase;
  UpdateTaskUseCase get updateTaskUseCase;
  UpdateStatusTaskUseCase get updateStatusTaskUseCase;
  DeleteTaskUseCase get deleteTaskUseCase;

  void saveTask(TaskType type) async {
    final task = TaskEntity(
      id: const Uuid().v4(),
      title: state.title.value,
      note: state.note,
      date: DateTime.parse(state.date.value),
      time: state.time,
      category: state.selectedCategory,
      isDone: false,
      type: type,
      createdAt: DateTime.now(),
    );

    final result = await createTaskUseCase.execute(
      CreateTaskRequest(task: task),
    );
    result.when(
      success: (data) {
        getTasks(TaskScheduleType.today);
        getTasks(TaskScheduleType.upcoming);
        state = state.copyWith(saveResult: Resource.success(true));
      },
      failure: (error) {
        state = state.copyWith(saveResult: Resource.failure(error));
      },
    );
  }

  void deleteTask(String taskId) async {
    final result = await deleteTaskUseCase.execute(
      DeleteTaskRequest(id: taskId),
    );
    result.when(
      success: (data) {
        state = state.copyWith(deleteResult: Resource.success(true));
        getTasks(TaskScheduleType.today);
        getTasks(TaskScheduleType.upcoming);
      },
      failure: (error) {
        state = state.copyWith(deleteResult: Resource.failure(error));
      },
    );
  }

  void updateStatus(
    String id,
    bool status,
    TaskScheduleType taskTabsType,
  ) async {
    final result = await updateStatusTaskUseCase.execute(
      UpdateStatusTaskRequest(id: id, status: status),
    );
    result.when(
      success: (data) {
        state = state.copyWith(updateResult: Resource.success(true));
        getTasks(taskTabsType);
      },
      failure: (error) {
        state = state.copyWith(updateResult: Resource.failure(error));
      },
    );
  }

  void updateTask(String id) async {
    final task = TaskEntity(
      id: id,
      title: state.title.value,
      note: state.note,
      date: DateTime.parse(state.date.value),
      time: state.time,
      category: state.selectedCategory,
      updatedAt: DateTime.now(),
    );

    final result = await updateTaskUseCase.execute(
      UpdateTaskRequest(task: task, id: id),
    );

    result.when(
      success: (data) {
        state = state.copyWith(updateResult: Resource.success(true));
        getTasks(TaskScheduleType.today);
        getTasks(TaskScheduleType.upcoming);
      },
      failure: (error) {
        state = state.copyWith(updateResult: Resource.failure(error));
      },
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
