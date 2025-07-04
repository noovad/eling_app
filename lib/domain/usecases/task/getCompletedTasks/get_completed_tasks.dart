import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/task_repository.dart';
import 'package:eling/domain/entities/task/task.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/task/getCompletedTasks/get_completed_tasks_request.dart';

abstract class GetCompletedTasksUseCase {
  Future<Result<List<TaskEntity>>> execute(GetCompletedTasksRequest request);
}

class GetCompletedTasksUseCaseImpl
    extends BaseUsecase<GetCompletedTasksRequest, List<TaskEntity>>
    implements GetCompletedTasksUseCase {
  final TaskRepository _taskRepository;

  @override
  String get usecaseName => 'GetCompletedTasksUseCase';

  GetCompletedTasksUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<List<TaskEntity>>> execute(
    GetCompletedTasksRequest request,
  ) async {
    return safeExecute(request, () async {
      final tasks = await _taskRepository.readCompletedTasks(
        month: request.month,
        year: request.year,
      );
      return tasks;
    });
  }
}
