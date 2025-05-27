import 'package:eling_app/core/utils/constants/date_constants.dart';
import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/data/model/database_constants.dart';
import 'package:eling_app/domain/entities/task/task.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/presentation/enum/task_type.dart';

class TaskRepository {
  final ElingDatabase _database;

  TaskRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<TaskEntity> createTask(TaskEntity task) async {
    return _database.create<TaskEntity>(
      TableNames.tasks,
      task,
      (task) => task.toJson(),
    );
  }

  Future<TaskGroupResultEntity> getTodayTasks() async {
    final db = await _database.database;
    final todayStr = DateConstants.todayStr;

    final todayTasks = await db.query(
      TableNames.tasks,
      where: '${TaskFields.date} = ?',
      whereArgs: [todayStr],
    );

    final overdueTasks = await db.query(
      TableNames.tasks,
      where: '${TaskFields.date} < ?',
      whereArgs: [todayStr],
    );

    final allTasks = [
      ...todayTasks.map((json) => TaskEntity.fromJson(json)),
      ...overdueTasks.map((json) => TaskEntity.fromJson(json)),
    ];

    return _groupTasksByType(allTasks);
  }

  Future<TaskGroupResultEntity> getUpcomingTasks() async {
    final db = await _database.database;
    final todayStr = DateConstants.todayStr;

    final futureTasks = await db.query(
      TableNames.tasks,
      where: '${TaskFields.date} > ? AND ${TaskFields.isDone} = ?',
      whereArgs: [todayStr, 0],
      orderBy: '${TaskFields.date} ASC',
    );

    final tasks = futureTasks.map((json) => TaskEntity.fromJson(json)).toList();

    return _groupTasksByType(tasks);
  }

  Future<List<TaskEntity>> readCompletedTasks({
    required int month,
    required int year,
  }) async {
    final db = await _database.database;

    final result = await db.query(
      TableNames.tasks,
      where: '''
        ${TaskFields.isDone} = ? AND
        strftime('%m', ${TaskFields.date}) = ? AND
        strftime('%Y', ${TaskFields.date}) = ?
      ''',
      whereArgs: [1, month.toString().padLeft(2, '0'), year.toString()],
    );

    return result.map((json) => TaskEntity.fromJson(json)).toList();
  }

  Future<int> updateTask(TaskEntity task, String id) async {
    return _database.update(TableNames.tasks, task.toJson(), id);
  }

  Future<int> updateTaskStatus(String id, bool isDone) async {
    final db = await _database.database;

    return await db.update(
      TableNames.tasks,
      {TaskFields.isDone: !isDone ? 1 : 0},
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTask(String id) async {
    return _database.delete(TableNames.tasks, id);
  }

  TaskGroupResultEntity _groupTasksByType(List<TaskEntity> tasks) {
    final Map<TaskType, List<TaskEntity>> tasksByType = {
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

    return TaskGroupResultEntity(tasksByType: tasksByType);
  }
}
