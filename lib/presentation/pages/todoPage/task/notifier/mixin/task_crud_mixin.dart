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
        state = state.copyWith(saveResult: Resource.success('task'));
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
        state = state.copyWith(deleteResult: Resource.success('task'));
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
        state = state.copyWith(updateStatusResult: Resource.success('task'));
        getTasks(taskTabsType);
      },
      failure: (error) {
        state = state.copyWith(updateStatusResult: Resource.failure(error));
      },
    );
  }

  void updateTask(TaskEntity task) async {
    final data = TaskEntity(
      id: task.id,
      isDone: task.isDone,
      type: task.type,
      createdAt: task.createdAt,
      title: state.title.value,
      note: state.note,
      date: DateTime.parse(state.date.value),
      time: state.time,
      category: state.selectedCategory,
      updatedAt: DateTime.now(),
    );

    final result = await updateTaskUseCase.execute(
      UpdateTaskRequest(task: data),
    );

    result.when(
      success: (data) {
        state = state.copyWith(updateResult: Resource.success('task'));
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
        if (taskTabsType case TaskScheduleType.today) {
          state = state.copyWith(todayTask: Resource.success(data));
        } else if (taskTabsType case TaskScheduleType.upcoming) {
          state = state.copyWith(upcomingTask: Resource.success(data));
        }
      },
      failure: (error) {
        if (taskTabsType case TaskScheduleType.today) {
          state = state.copyWith(todayTask: Resource.failure(error));
        } else if (taskTabsType case TaskScheduleType.upcoming) {
          state = state.copyWith(upcomingTask: Resource.failure(error));
        }
      },
    );
  }
}
