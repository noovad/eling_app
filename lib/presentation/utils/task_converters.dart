import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/recurringTask/recurring_task.dart';
import 'package:eling_app/domain/entities/recurringTaskGroupResult/recurring_task_group_result.dart';
import 'package:eling_app/domain/entities/task/task.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';

class TaskConverters {
  static Resource<TaskGroupResultEntity> convertRecurringToTaskGroupResource(
    Resource<RecurringTaskGroupResultEntity> source,
  ) {
    return source.maybeWhen(
      success: (recurringResult) {
        final tasksByType = recurringResult.tasksByType.map((
          type,
          recurringTasks,
        ) {
          final taskList = recurringTasks.map(convertRecurringToTask).toList();
          return MapEntry(type, taskList);
        });

        return Resource.success(
          TaskGroupResultEntity(tasksByType: tasksByType),
        );
      },
      orElse: () => const Resource.initial(),
    );
  }

  static TaskEntity convertRecurringToTask(RecurringTaskEntity recurring) {
    return TaskEntity(
      id: recurring.id,
      title: recurring.title,
      date: DateTime.now(),
      type: recurring.type,
      note: recurring.note,
      time: recurring.time,
      category: recurring.category,
      isDone: false,
      createdAt: recurring.createdAt,
      updatedAt: recurring.updatedAt,
    );
  }
}
