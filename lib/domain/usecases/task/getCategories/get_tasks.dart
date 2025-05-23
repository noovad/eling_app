import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/domain/entities/task/task.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/task/getCategories/get_tasks_request.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';

abstract class GetTasksUseCase {
  Future<Result<TaskGroupResultEntity>> execute(GetTasksRequest request);
}

class GetTasksUseCaseImpl
    extends BaseUsecase<GetTasksRequest, TaskGroupResultEntity>
    implements GetTasksUseCase {
  @override
  String get usecaseName => 'GetTasksUseCase';

  GetTasksUseCaseImpl({required super.logger});

  @override
  Future<Result<TaskGroupResultEntity>> execute(GetTasksRequest request) async {
    return safeExecute(request, () async {
      await Future.delayed(const Duration(seconds: 2));
      switch (request.name) {
        case TaskTabsType.today:
          return TaskGroupResultEntity(
            tasksByType: {
              TaskType.daily: [
                TaskEntity(
                  id: '1',
                  title: 'Daily Task 1',
                  note: 'Description for daily task 1',
                  category: 'personal',
                  date: DateTime.now(),
                  isDone: false,
                ),
                TaskEntity(
                  id: '2',
                  title: 'Daily Task 2',
                  note: 'Description for daily task 2',
                  category: 'work',
                  date: DateTime.now(),
                  isDone: false,
                ),
              ],
              TaskType.productivity: [
                TaskEntity(
                  id: '3',
                  title: 'Productivity Task 1',
                  note: 'Description for productivity task 1',
                  category: 'work',
                  date: DateTime.now(),
                  isDone: false,
                ),
              ],
            },
          );
        case TaskTabsType.upcoming:
          return TaskGroupResultEntity(
            tasksByType: {
              TaskType.daily: [
                TaskEntity(
                  id: '4',
                  title: 'Upcoming Daily Task',
                  note: 'Description for upcoming daily task',
                  category: 'personal',
                  date: DateTime.now().add(const Duration(days: 2)),
                  isDone: false,
                ),
              ],
              TaskType.productivity: [
                TaskEntity(
                  id: '5',
                  title: 'Upcoming Productivity Task',
                  note: 'Description for upcoming productivity task',
                  category: 'work',
                  date: DateTime.now().add(const Duration(days: 3)),
                  isDone: false,
                ),
              ],
            },
          );
        case TaskTabsType.recurring:
          return TaskGroupResultEntity(
            tasksByType: {
              TaskType.daily: [
                TaskEntity(
                  id: '6',
                  title: 'Recurring Daily Task',
                  note: 'Description for recurring daily task',
                  category: 'personal',
                  date: DateTime.now(),
                  isDone: false,
                ),
              ],
              TaskType.productivity: [
                TaskEntity(
                  id: '7',
                  title: 'Recurring Productivity Task',
                  note: 'Description for recurring productivity task',
                  category: 'work',
                  date: DateTime.now(),
                  isDone: false,
                ),
              ],
            },
          );
        case TaskTabsType.completed:
          return TaskGroupResultEntity(
            tasksByType: {
              TaskType.daily: [
                TaskEntity(
                  id: '8',
                  title: 'Completed Daily Task',
                  note: 'Description for completed daily task',
                  category: 'personal',
                  date: DateTime.now().subtract(const Duration(days: 1)),
                  isDone: true,
                ),
              ],
              TaskType.productivity: [
                TaskEntity(
                  id: '9',
                  title: 'Completed Productivity Task',
                  note: 'Description for completed productivity task',
                  category: 'work',
                  date: DateTime.now().subtract(const Duration(days: 2)),
                  isDone: true,
                ),
              ],
            },
          );
      }
    });
  }
}
