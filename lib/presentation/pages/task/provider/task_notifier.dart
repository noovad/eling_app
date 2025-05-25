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
import 'package:eling_app/presentation/enum/task_schedule_type.dart';
import 'package:eling_app/presentation/pages/task/models/category_title.dart';
import 'package:eling_app/presentation/pages/task/models/date.dart';
import 'package:eling_app/presentation/pages/task/models/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'task_state.dart';
part 'task_notifier.freezed.dart';
part 'parts/task_crud_logic.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCompletedTasksUseCase getCompletedTasksUseCase;

  TaskNotifier(
    this.getTasksUseCase,
    this.getCategoriesUseCase,
    this.getCompletedTasksUseCase,
  ) : super(TaskState.initial()) {
    getTasks(TaskScheduleType.today);
    getTasks(TaskScheduleType.recurring);
    getTasks(TaskScheduleType.upcoming);
    getCategories(CategoryType.daily);
    getCategories(CategoryType.productivity);
    getCategories(CategoryType.note);
    getCompletedTasks(state.monthFilter, state.yearFilter);
  }

  // CRUD Task
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

  // CRUD Category
  void saveCategory() async {
    final categoryTitle = state.categoryTitle.value;
    debugPrint('Saving category with title: $categoryTitle');
  }

  void getCategories(CategoryType categoryType) async {
    final result = await getCategoriesUseCase.execute(
      GetCategoriesRequest(categoryType: categoryType),
    );
    result.when(
      success: (data) {
        switch (categoryType) {
          case CategoryType.daily:
            state = state.copyWith(dailyCategories: Resource.success(data));
          case CategoryType.productivity:
            state = state.copyWith(
              productivityCategories: Resource.success(data),
            );
          case CategoryType.note:
            state = state.copyWith(noteCategories: Resource.success(data));
        }
      },
      failure: (error) {
        switch (categoryType) {
          case CategoryType.daily:
            state = state.copyWith(dailyCategories: Resource.failure(error));
          case CategoryType.productivity:
            state = state.copyWith(
              productivityCategories: Resource.failure(error),
            );
          case CategoryType.note:
            state = state.copyWith(noteCategories: Resource.failure(error));
        }
      },
    );
  }

  // Task Form
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
    state = state.copyWith(time: value);
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

  // Category Form
  void categoyrTitleChanged(String value) {
    final categoryTitle = CategoryTitle.dirty(value: value);
    final isValidCategory = Formz.validate([categoryTitle]);
    state = state.copyWith(
      categoryTitle: categoryTitle,
      isValidCategory: isValidCategory,
    );
  }

  void resetCategoryForm() {
    state = state.copyWith(
      categoryTitle: CategoryTitle.pure(),
      isValidCategory: false,
    );
  }

  // Completed Tasks
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

  void monthFilterChanged(int value) {
    state = state.copyWith(monthFilter: value);
  }

  void yearFilterChanged(int value) {
    state = state.copyWith(yearFilter: value);
  }
}
