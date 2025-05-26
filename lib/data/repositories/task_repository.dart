import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/data/model/database_constants.dart';
import 'package:eling_app/domain/entities/task/task.dart';

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

  Future<TaskEntity?> readTask(String id) async {
    final results = await _database.read(
      TableNames.tasks,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return TaskEntity.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<List<TaskEntity>> readAllTasks() async {
    final results = await _database.read(TableNames.tasks);
    return results.map((json) => TaskEntity.fromJson(json)).toList();
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

  Future<int> updateTask(TaskEntity task) async {
    return _database.update(TableNames.tasks, task.toJson(), task.id);
  }

  Future<int> deleteTask(String id) async {
    return _database.delete(TableNames.tasks, id);
  }
}
