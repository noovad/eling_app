import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/task/updateStatusTask/update_status_task_request.dart';

abstract class UpdateStatusTaskUseCase {
  Future<Result<int>> execute(UpdateStatusTaskRequest request);
}

class UpdateStatusTaskUseCaseImpl
    extends BaseUsecase<UpdateStatusTaskRequest, int>
    implements UpdateStatusTaskUseCase {
  final TaskRepository _taskRepository;

  @override
  String get usecaseName => 'UpdateStatusTaskUseCase';

  UpdateStatusTaskUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<int>> execute(UpdateStatusTaskRequest request) async {
    return safeExecute(request, () async {
      final tasks = await _taskRepository.updateTaskStatus(
        request.id,
        request.status,
      );
      return tasks;
    });
  }
}
