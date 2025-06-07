import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/task_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/task/deleteTask/delete_task_request.dart';

abstract class DeleteTaskUseCase {
  Future<Result<int>> execute(DeleteTaskRequest request);
}

class DeleteTaskUseCaseImpl extends BaseUsecase<DeleteTaskRequest, int>
    implements DeleteTaskUseCase {
  final TaskRepository _taskRepository;
  @override
  String get usecaseName => 'DeleteTaskUseCase';

  DeleteTaskUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<int>> execute(DeleteTaskRequest request) async {
    return safeExecute(request, () async {
      final tasks = await _taskRepository.deleteTask(request.id);
      return tasks;
    });
  }
}
