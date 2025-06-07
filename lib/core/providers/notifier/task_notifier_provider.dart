import 'package:eling/core/providers/usecase/category/createCategory/create_category_provider.dart';
import 'package:eling/core/providers/usecase/category/deleteCategory/delete_category_provider.dart';
import 'package:eling/core/providers/usecase/category/getCategories/get_categories_provider.dart';
import 'package:eling/core/providers/usecase/recurringTask/createRecurringTask/create_recurring_task_provider.dart';
import 'package:eling/core/providers/usecase/recurringTask/deleteRecurringTask/delete_recurring_task_provider.dart';
import 'package:eling/core/providers/usecase/recurringTask/getRecurringTasks/get_recurring_tasks_provider.dart';
import 'package:eling/core/providers/usecase/recurringTask/updateRecurringTask/update_recurring_task_provider.dart';
import 'package:eling/core/providers/usecase/task/createTask/create_task_provider.dart';
import 'package:eling/core/providers/usecase/task/deleteTask/delete_task_provider.dart';
import 'package:eling/core/providers/usecase/task/getCompletedTasks/get_completed_tasks_provider.dart';
import 'package:eling/core/providers/usecase/task/getTasks/get_tasks_provider.dart';
import 'package:eling/core/providers/usecase/task/updateStatusTask/update_status_task_provider.dart';
import 'package:eling/core/providers/usecase/task/updateTask/update_task_provider.dart';
import 'package:eling/presentation/pages/todoPage/task/notifier/task_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, TaskState>((
  ref,
) {
  return TaskNotifier(
    ref.watch(getTasksUseCaseProvider),
    ref.watch(getCategoriesUseCaseProvider),
    ref.watch(getCompletedTasksUseCaseProvider),
    ref.watch(createTaskUseCaseProvider),
    ref.watch(updateTaskUseCaseProvider),
    ref.watch(updateStatusTaskUseCaseProvider),
    ref.watch(deleteTaskUseCaseProvider),
    ref.watch(getRecurringTasksUseCaseProvider),
    ref.watch(createRecurringTaskUseCaseProvider),
    ref.watch(updateRecurringTaskUseCaseProvider),
    ref.watch(deleteRecurringTaskUseCaseProvider),
    ref.watch(createCategoryUseCaseProvider),
    ref.watch(deleteCategoryUseCaseProvider),
  );
});
