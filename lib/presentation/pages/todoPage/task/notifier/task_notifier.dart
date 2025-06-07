import 'package:eling/core/enum/category_type.dart';
import 'package:eling/domain/entities/category/category.dart';
import 'package:eling/domain/entities/recurringTask/recurring_task.dart';
import 'package:eling/domain/entities/recurringTaskGroupResult/recurring_task_group_result.dart';
import 'package:eling/domain/entities/task/task.dart';
import 'package:eling/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/category/createCategory/create_category.dart';
import 'package:eling/domain/usecases/category/createCategory/create_category_request.dart';
import 'package:eling/domain/usecases/category/deleteCategory/delete_category.dart';
import 'package:eling/domain/usecases/category/deleteCategory/delete_category_request.dart';
import 'package:eling/domain/usecases/category/getCategories/get_categories.dart';
import 'package:eling/domain/usecases/category/getCategories/get_categories_request.dart';
import 'package:eling/domain/usecases/recurringTask/createRecurringTask/create_recurring_task_request.dart';
import 'package:eling/domain/usecases/recurringTask/createRecurringTask/create_recurring_task.dart';
import 'package:eling/domain/usecases/recurringTask/deleteRecurringTask/delete_recurring_task_request.dart';
import 'package:eling/domain/usecases/recurringTask/deleteRecurringTask/delete_recurring_task.dart';
import 'package:eling/domain/usecases/recurringTask/getRecurringTasks/get_recurring_tasks.dart';
import 'package:eling/domain/usecases/recurringTask/updateRecurringTask/update_recurring_task_request.dart';
import 'package:eling/domain/usecases/recurringTask/updateRecurringTask/update_recurring_task.dart';
import 'package:eling/domain/usecases/task/createTask/create_task_request.dart';
import 'package:eling/domain/usecases/task/createTask/create_task.dart';
import 'package:eling/domain/usecases/task/deleteTask/delete_task_request.dart';
import 'package:eling/domain/usecases/task/deleteTask/delete_task.dart';
import 'package:eling/domain/usecases/task/getTasks/get_tasks.dart';
import 'package:eling/domain/usecases/task/getTasks/get_tasks_request.dart';
import 'package:eling/domain/usecases/task/getCompletedTasks/get_completed_tasks_request.dart';
import 'package:eling/domain/usecases/task/getCompletedTasks/get_completed_tasks.dart';
import 'package:eling/domain/usecases/task/updateStatusTask/update_status_task_request.dart';
import 'package:eling/domain/usecases/task/updateStatusTask/update_status_task.dart';
import 'package:eling/domain/usecases/task/updateTask/update_task_request.dart';
import 'package:eling/domain/usecases/task/updateTask/update_task.dart';
import 'package:eling/presentation/enum/task_schedule_type.dart';
import 'package:eling/presentation/enum/task_type.dart';
import 'package:eling/presentation/pages/todoPage/task/models/category_title.dart';
import 'package:eling/presentation/pages/todoPage/task/models/date.dart';
import 'package:eling/presentation/pages/todoPage/task/models/title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling/core/utils/resource.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';
part 'task_notifier.freezed.dart';

part 'mixin/task_mixin.dart';
part 'mixin/category_mixin.dart';
part 'mixin/recurring_taks_mixin.dart';

class TaskNotifier extends StateNotifier<TaskState>
    with TaskMixin, CategoryMixin, RecurringTaksMixin {
  @override
  final GetTasksUseCase getTasksUseCase;
  @override
  final GetCategoriesUseCase getCategoriesUseCase;
  @override
  final GetCompletedTasksUseCase getCompletedTasksUseCase;
  @override
  final CreateTaskUseCase createTaskUseCase;
  @override
  UpdateStatusTaskUseCase updateStatusTaskUseCase;
  @override
  UpdateTaskUseCase updateTaskUseCase;
  @override
  DeleteTaskUseCase deleteTaskUseCase;
  @override
  final GetRecurringTasksUseCase getRecurringTasksUseCase;
  @override
  final CreateRecurringTaskUseCase createRecurringTaskUseCase;
  @override
  final UpdateRecurringTaskUseCase updateRecurringTaskUseCase;
  @override
  final DeleteRecurringTaskUseCase deleteRecurringTaskUseCase;
  @override
  final CreateCategoryUseCase createCategoryUseCase;
  @override
  final DeleteCategoryUseCase deleteCategoryUseCase;

  TaskNotifier(
    this.getTasksUseCase,
    this.getCategoriesUseCase,
    this.getCompletedTasksUseCase,
    this.createTaskUseCase,
    this.updateTaskUseCase,
    this.updateStatusTaskUseCase,
    this.deleteTaskUseCase,
    this.getRecurringTasksUseCase,
    this.createRecurringTaskUseCase,
    this.updateRecurringTaskUseCase,
    this.deleteRecurringTaskUseCase,
    this.createCategoryUseCase,
    this.deleteCategoryUseCase,
  ) : super(TaskState.initial()) {
    getTasks(TaskScheduleType.today);
    getTasks(TaskScheduleType.upcoming);
    getCompletedTasks();
    getCategories(CategoryType.daily);
    getCategories(CategoryType.productivity);
    getCategories(CategoryType.note);
    getRecurringTasks();
  }
}
