part of '../task_notifier.dart';

mixin RecurringTaksMixin on StateNotifier<TaskState> {
  GetRecurringTasksUseCase get getRecurringTasksUseCase;
  CreateRecurringTaskUseCase get createRecurringTaskUseCase;
  UpdateRecurringTaskUseCase get updateRecurringTaskUseCase;
  DeleteRecurringTaskUseCase get deleteRecurringTaskUseCase;

  void createRecurringTask(TaskType type) async {
    final data = RecurringTaskEntity(
      id: const Uuid().v4(),
      title: state.title.value,
      note: state.note,
      time: state.time,
      category: state.selectedCategory,
      type: type,
      createdAt: DateTime.now(),
    );

    final result = await createRecurringTaskUseCase.execute(
      CreateRecurringTaskRequest(recurringTask: data),
    );
    result.when(
      success: (_) {
        getRecurringTasks();
        state = state.copyWith(saveResult: Resource.success('recurring_task'));
      },
      failure: (_) {
        state = state.copyWith(saveResult: Resource.failure('recurring_task'));
      },
    );
  }

  void deleteRecurringTask(String taskId) async {
    final result = await deleteRecurringTaskUseCase.execute(
      DeleteRecurringTaskRequest(id: taskId),
    );
    result.when(
      success: (_) {
        getRecurringTasks();
        state = state.copyWith(
          deleteResult: Resource.success('recurring_task'),
        );
      },
      failure: (_) {
        state = state.copyWith(deleteResult: Resource.failure('recurring_task'));
      },
    );
  }

  void updateRecurringTask(TaskEntity task) async {
    final data = RecurringTaskEntity(
      id: task.id,
      type: task.type,
      createdAt: task.createdAt,
      title: state.title.value,
      note: state.note,
      time: state.time,
      category: state.selectedCategory,
      updatedAt: DateTime.now(),
    );

    final result = await updateRecurringTaskUseCase.execute(
      UpdateRecurringTaskRequest(recurringTask: data),
    );

    result.when(
      success: (_) {
        getRecurringTasks();
        state = state.copyWith(
          updateResult: Resource.success('recurring_task'),
        );
      },
      failure: (_) {
        state = state.copyWith(updateResult: Resource.failure('recurring_task'));
      },
    );
  }

  void getRecurringTasks() async {
    final result = await getRecurringTasksUseCase.execute(NoRequest());
    result.when(
      success: (data) {
        state = state.copyWith(recurringTask: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(recurringTask: Resource.failure(error));
      },
    );
  }
}
