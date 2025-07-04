import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/task_repository.dart';
import 'package:eling/domain/entities/task/task.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/task/createTask/create_task_request.dart';

abstract class CreateTaskUseCase {
  Future<Result<TaskEntity>> execute(CreateTaskRequest request);
}

class CreateTaskUseCaseImpl extends BaseUsecase<CreateTaskRequest, TaskEntity>
    implements CreateTaskUseCase {
  final TaskRepository _taskRepository;

  @override
  String get usecaseName => 'CreateTaskUseCase';

  CreateTaskUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<TaskEntity>> execute(CreateTaskRequest request) async {
    return safeExecute(request, () async {
      final tasks = await _taskRepository.createTask(request.task);
      return tasks;
    });
  }
}
