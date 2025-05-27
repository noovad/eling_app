import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/data/model/database_constants.dart';
import 'package:eling_app/domain/entities/recurringTask/recurring_task.dart';
import 'package:eling_app/domain/entities/recurringTaskGroupResult/recurring_task_group_result.dart';
import 'package:eling_app/presentation/enum/task_type.dart';

class RecurringTaskRepository {
  final ElingDatabase _database;

  RecurringTaskRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<RecurringTaskEntity> createRecurringTask(
    RecurringTaskEntity task,
  ) async {
    return _database.create<RecurringTaskEntity>(
      TableNames.recurringTasks,
      task,
      (task) => task.toJson(),
    );
  }

  Future<RecurringTaskGroupResultEntity> getTasks() async {
    final db = await _database.database;

    final recurringTasksData = await db.query(TableNames.recurringTasks);
    final recurringTasks =
        recurringTasksData
            .map((json) => RecurringTaskEntity.fromJson(json))
            .toList();

    return _groupTasksByType(recurringTasks);
  }

  Future<int> updateRecurringTask(RecurringTaskEntity task) async {
    return _database.update(TableNames.recurringTasks, task.toJson(), task.id);
  }

  Future<int> deleteRecurringTask(String id) async {
    return _database.delete(TableNames.recurringTasks, id);
  }

  RecurringTaskGroupResultEntity _groupTasksByType(
    List<RecurringTaskEntity> tasks,
  ) {
    final Map<TaskType, List<RecurringTaskEntity>> tasksByType = {
      for (final type in TaskType.values) type: [],
    };

    for (final task in tasks) {
      TaskType? taskType;
      switch (task.type) {
        case TaskType.daily:
          taskType = TaskType.daily;
          break;
        case TaskType.productivity:
          taskType = TaskType.productivity;
          break;
      }

      tasksByType[taskType]?.add(task);
    }

    return RecurringTaskGroupResultEntity(tasksByType: tasksByType);
  }
}
