import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/task_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/task/updateTask/update_task_request.dart';

abstract class UpdateTaskUseCase {
  Future<Result<int>> execute(UpdateTaskRequest request);
}

class UpdateTaskUseCaseImpl extends BaseUsecase<UpdateTaskRequest, int>
    implements UpdateTaskUseCase {
  final TaskRepository _taskRepository;

  @override
  String get usecaseName => 'UpdateTaskUseCase';

  UpdateTaskUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<int>> execute(UpdateTaskRequest request) async {
    return safeExecute(request, () async {
      final tasks = await _taskRepository.updateTask(request.task);
      return tasks;
    });
  }
}
