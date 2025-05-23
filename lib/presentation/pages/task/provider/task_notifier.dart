import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks_request.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'task_state.dart';
part 'task_notifier.freezed.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final GetTasksUseCase getTasksUseCase;

  TaskNotifier(this.getTasksUseCase) : super(TaskState.initial()) {
    getTasksToday();
    getTasksUpcoming();
    getTasksRecurring();
  }

  void getTasksToday() async {
    final result = await getTasksUseCase.execute(
      const GetTasksRequest(name: TaskTabsType.today),
    );
    result.when(
      success: (data) {
        state = state.copyWith(todayTask: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(todayTask: Resource.failure(error));
      },
    );
  }

  void getTasksUpcoming() async {
    final result = await getTasksUseCase.execute(
      const GetTasksRequest(name: TaskTabsType.upcoming),
    );
    result.when(
      success: (data) {
        state = state.copyWith(upcomingTask: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(upcomingTask: Resource.failure(error));
      },
    );
  }

  void getTasksRecurring() async {
    final result = await getTasksUseCase.execute(
      const GetTasksRequest(name: TaskTabsType.recurring),
    );
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
