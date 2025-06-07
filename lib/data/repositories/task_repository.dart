import 'package:eling/core/utils/constants/date_constants.dart';
import 'package:eling/data/eling_database.dart';
import 'package:eling/data/model/database_constants.dart';
import 'package:eling/domain/entities/dailyActivity/daily_activity.dart';
import 'package:eling/domain/entities/recurringTask/recurring_task.dart';
import 'package:eling/domain/entities/task/task.dart';
import 'package:eling/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling/presentation/enum/task_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TaskRepository {
  final ElingDatabase _database;
  static const _lastRunKey = 'lastRecurringTaskGenerationDate';

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

    final tasks = await db.query(
      TableNames.tasks,
      where:
          '(${TaskFields.date} < ? AND ${TaskFields.isDone} = 0) OR ${TaskFields.date} = ?',
      whereArgs: [todayStr, todayStr],
      orderBy: '${TaskFields.isDone} ASC, ${TaskFields.date} ASC',
    );

    return _groupTasksByType(
      tasks.map((json) => TaskEntity.fromJson(json)).toList(),
    );
  }

  Future<TaskGroupResultEntity> getUpcomingTasks() async {
    final db = await _database.database;
    final todayStr = DateConstants.todayStr;

    final futureTasks = await db.query(
      TableNames.tasks,
      where: '${TaskFields.date} > ? AND ${TaskFields.isDone} = ?',
      whereArgs: [todayStr, 0],
      orderBy: '${TaskFields.isDone} ASC, ${TaskFields.date} ASC',
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
      orderBy: '${TaskFields.date} DESC',
    );

    return result.map((json) => TaskEntity.fromJson(json)).toList();
  }

  Future<int> updateTask(TaskEntity task) async {
    return _database.update(TableNames.tasks, task.toJson(), task.id);
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

  Future<List<DailyActivityEntity>> getDailyActivities({
    required int month,
    required int year,
  }) async {
    final db = await _database.database;

    final monthStr = month.toString().padLeft(2, '0');
    final yearStr = year.toString();

    final result = await db.query(
      TableNames.tasks,
      where: '''
      ${TaskFields.isDone} = ? AND
      strftime('%m', ${TaskFields.date}) = ? AND
      strftime('%Y', ${TaskFields.date}) = ?
    ''',
      whereArgs: [1, monthStr, yearStr],
    );

    final tasks = result.map((json) => TaskEntity.fromJson(json)).toList();

    final Map<DateTime, List<TaskEntity>> taskByDate = {};
    for (final task in tasks) {
      final date = DateTime.parse(
        (task.date).toString(),
      ).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
      taskByDate.putIfAbsent(date, () => []).add(task);
    }

    final List<DailyActivityEntity> dailyActivities = [];

    for (int day = 1; day <= 31; day++) {
      DateTime date;
      try {
        date = DateTime(year, month, day);
      } catch (_) {
        break;
      }

      final tasksForDay = taskByDate[date] ?? [];

      final sholat =
          tasksForDay.where((t) => t.category == 'Sholat Fardhu').length;
      final gym = tasksForDay.any((t) => t.category == 'Gym');
      final cardio = tasksForDay.any((t) => t.category == 'Cardio');
      final coding = tasksForDay.any((t) => t.category == 'Coding');
      final calorieControlled = tasksForDay.any(
        (t) => t.category == 'Calorie Controlled',
      );

      dailyActivities.add(
        DailyActivityEntity(
          date: date,
          sholat: sholat,
          gym: gym,
          cardio: cardio,
          coding: coding,
          amount: 0,
          calorieControlled: calorieControlled,
        ),
      );
    }

    return dailyActivities;
  }

  Future<void> generateTodayTasksFromRecurring() async {
    final db = await _database.database;
    final todayStr = DateConstants.todayStr;

    final recurringTasksData = await db.query(TableNames.recurringTasks);
    final recurringTasks =
        recurringTasksData
            .map((json) => RecurringTaskEntity.fromJson(json))
            .toList();

    for (final task in recurringTasks) {
      final newTask = TaskEntity(
        id: const Uuid().v4(),
        title: task.title,
        type: task.type,
        category: task.category,
        date: DateTime.parse(todayStr),
        isDone: false,
        createdAt: DateTime.now(),
      );
      await createTask(newTask);
    }
  }

  Future<void> generateTodayTasksFromRecurringOncePerDay() async {
    final prefs = await SharedPreferences.getInstance();
    final todayStr = DateConstants.todayStr;

    final lastRun = prefs.getString(_lastRunKey);
    if (lastRun == todayStr) {
      return;
    }

    await generateTodayTasksFromRecurring();

    await prefs.setString(_lastRunKey, todayStr);
  }
}
