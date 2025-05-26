part of '../task_notifier.dart';

mixin CompletedTaskMixin on StateNotifier<TaskState> {
  GetCompletedTasksUseCase get getCompletedTasksUseCase;

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
}
