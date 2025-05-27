import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/task/getTasks/get_tasks_request.dart';
import 'package:eling_app/presentation/enum/task_schedule_type.dart';

abstract class GetTasksUseCase {
  Future<Result<TaskGroupResultEntity>> execute(GetTasksRequest request);
}

class GetTasksUseCaseImpl
    extends BaseUsecase<GetTasksRequest, TaskGroupResultEntity>
    implements GetTasksUseCase {
  final TaskRepository _taskRepository;

  @override
  String get usecaseName => 'GetTasksUseCase';

  GetTasksUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<TaskGroupResultEntity>> execute(GetTasksRequest request) async {
    return safeExecute(request, () async {
      switch (request.type) {
        case TaskScheduleType.today:
          final tasks = await _taskRepository.getTodayTasks();
          return tasks;
        case TaskScheduleType.upcoming:
          final tasks = await _taskRepository.getUpcomingTasks();
          return tasks;
        case TaskScheduleType.recurring:
          final tasks = await _taskRepository.getUpcomingTasks();
          return tasks;
      }
    });
  }
}
