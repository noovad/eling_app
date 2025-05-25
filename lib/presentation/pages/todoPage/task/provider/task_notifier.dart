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
import 'package:eling_app/presentation/pages/todoPage/task/models/category_title.dart';
import 'package:eling_app/presentation/pages/todoPage/task/models/date.dart';
import 'package:eling_app/presentation/pages/todoPage/task/models/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'task_state.dart';
part 'task_notifier.freezed.dart';

part 'mixin/task_crud_mixin.dart';
part 'mixin/category_crud_mixin.dart';
part 'mixin/task_form_mixin.dart';
part 'mixin/category_form_mixin.dart';
part 'mixin/completed_task_mixin.dart';

class TaskNotifier extends StateNotifier<TaskState>
    with
        TaskCRUDMixin,
        CategoryCRUDMixin,
        TaskFormMixin,
        CategoryFormMixin,
        CompletedTaskMixin {
  @override
  final GetTasksUseCase getTasksUseCase;
  @override
  final GetCategoriesUseCase getCategoriesUseCase;
  @override
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
}
