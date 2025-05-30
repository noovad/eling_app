part of '../task_notifier.dart';

mixin TaskMixin on StateNotifier<TaskState> {
  GetTasksUseCase get getTasksUseCase;
  CreateTaskUseCase get createTaskUseCase;
  UpdateTaskUseCase get updateTaskUseCase;
  UpdateStatusTaskUseCase get updateStatusTaskUseCase;
  DeleteTaskUseCase get deleteTaskUseCase;
  GetCompletedTasksUseCase get getCompletedTasksUseCase;

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
        getTasks(taskTabsType);
        state = state.copyWith(updateStatusResult: Resource.success('task'));
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

  void getCompletedTasks(int month, int year) async {
    Future.microtask(() {
      state = state.copyWith(completedTasks: Resource.loading());
    });
    final result = await getCompletedTasksUseCase.execute(
      GetCompletedTasksRequest(month: month, year: year),
    );
    result.when(
      success: (data) {
        state = state.copyWith(completedTasks: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(completedTasks: Resource.failure(error));
      },
    );
  }

  void titleChanged(String value) {
    final title = TitleInput.dirty(value: value);
    final isValid = Formz.validate([title, state.date]);
    state = state.copyWith(title: title, isValid: isValid);
  }

  void dateChanged(String value) {
    final date = DateInput.dirty(value: value);
    final isValid = Formz.validate([state.title, date]);
    state = state.copyWith(date: date, isValid: isValid);
  }

  void categoryChanged(String value) {
    state = state.copyWith(selectedCategory: value);
  }

  void timeChanged(String value) {
    final time = value == '00:00' ? null : value;
    state = state.copyWith(time: time);
  }

  void noteChanged(String value) {
    state = state.copyWith(note: value);
  }

  void setUpdateForm(TaskEntity task, TaskScheduleType? tabsType) {
    final isRecurring = tabsType == TaskScheduleType.recurring;
    final dateValue =
        isRecurring ? DateTime.now().toString() : task.date.toString();
    state = state.copyWith(
      title: TitleInput.dirty(value: task.title),
      date: DateInput.dirty(value: dateValue),
      isValid: true,
      selectedCategory: task.category,
      note: task.note,
      time: task.time,
    );
  }

  void resetForm(TaskScheduleType tabsType) {
    final isRecurring = tabsType == TaskScheduleType.recurring;
    state = state.copyWith(
      title: TitleInput.pure(),
      date:
          isRecurring
              ? DateInput.dirty(value: DateTime.now().toString())
              : DateInput.pure(),
      isValid: false,
      selectedCategory: null,
      note: null,
      time: null,
    );
  }

  void resetIsSaving() {
    state = state.copyWith(saveResult: Resource.initial());
  }

  void resetIsUpdate() {
    state = state.copyWith(updateResult: Resource.initial());
  }
}
