import 'package:eling_app/core/enum/category_type.dart';
import 'package:eling_app/domain/entities/category/category.dart';
import 'package:eling_app/domain/entities/task/task.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories_request.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks_request.dart';
import 'package:eling_app/domain/usecases/task/get_completed_tasks/get_completed_tasks_request.dart';
import 'package:eling_app/domain/usecases/task/get_completed_tasks/get_completed_tasks_usecase.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/pages/task/models/date.dart';
import 'package:eling_app/presentation/pages/task/models/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'task_state.dart';
part 'task_notifier.freezed.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCompletedTasksUseCase getCompletedTasksUseCase;

  TaskNotifier(
    this.getTasksUseCase,
    this.getCategoriesUseCase,
    this.getCompletedTasksUseCase,
  ) : super(TaskState.initial()) {
    getTasksToday();
    getTasksUpcoming();
    getTasksRecurring();
    getDailyCategories();
    getProductivityCategories();
    getCompletedTasks(state.monthFilter, state.yearFilter);
  }

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

  void getDailyCategories() async {
    final result = await getCategoriesUseCase.execute(
      const GetCategoriesRequest(categoryType: CategoryType.daily),
    );
    result.when(
      success: (data) {
        state = state.copyWith(dailyCategories: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(dailyCategories: Resource.failure(error));
      },
    );
  }

  void getProductivityCategories() async {
    final result = await getCategoriesUseCase.execute(
      const GetCategoriesRequest(categoryType: CategoryType.productivity),
    );
    result.when(
      success: (data) {
        state = state.copyWith(productivityCategories: Resource.success(data));
      },
      failure: (error) {
        state = state.copyWith(productivityCategories: Resource.failure(error));
      },
    );
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

  void getCompletedTasks(int month, int year) async {
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
    state = state.copyWith(title: title, isvalid: isValid);
  }

  void dateChanged(String value) {
    final date = DateInput.dirty(value: value);
    final isValid = Formz.validate([state.title, date]);
    state = state.copyWith(date: date, isvalid: isValid);
  }

  void categoryChanged(String value) {
    state = state.copyWith(selectedCategory: value);
  }

  void timeChanged(String value) {
    state = state.copyWith(time: value);
  }

  void noteChanged(String value) {
    state = state.copyWith(note: value);
  }

  void monthFilterChanged(int value) {
    state = state.copyWith(monthFilter: value);
  }

  void yearFilterChanged(int value) {
    state = state.copyWith(yearFilter: value);
  }

  void setUpdateForm(TaskEntity task, TaskTabsType tabsType) {
    final isRecurring = tabsType == TaskTabsType.recurring;
    final dateValue =
        isRecurring ? DateTime.now().toString() : task.date.toString();
    state = state.copyWith(
      title: TitleInput.dirty(value: task.title),
      date: DateInput.dirty(value: dateValue),
      isvalid: true,
      selectedCategory: task.category,
      note: task.note,
      time: task.time,
    );
  }

  void resetForm(TaskTabsType tabsType) {
    final isRecurring = tabsType == TaskTabsType.recurring;
    state = state.copyWith(
      title: TitleInput.pure(),
      date:
          isRecurring
              ? DateInput.dirty(value: DateTime.now().toString())
              : DateInput.pure(),
      isvalid: false,
      selectedCategory: null,
      note: null,
      time: null,
    );
  }
}
