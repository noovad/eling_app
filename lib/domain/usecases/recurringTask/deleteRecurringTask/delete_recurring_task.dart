import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/recurring_task_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/recurringTask/deleteRecurringTask/delete_recurring_task_request.dart';

abstract class DeleteRecurringTaskUseCase {
  Future<Result<int>> execute(DeleteRecurringTaskRequest request);
}

class DeleteRecurringTaskUseCaseImpl
    extends BaseUsecase<DeleteRecurringTaskRequest, int>
    implements DeleteRecurringTaskUseCase {
  final RecurringTaskRepository _recurringTaskRepository;
  @override
  String get usecaseName => 'DeleteRecurringTaskUseCase';

  DeleteRecurringTaskUseCaseImpl({
    required super.logger,
    required RecurringTaskRepository recurringTaskRepository,
  }) : _recurringTaskRepository = recurringTaskRepository;

  @override
  Future<Result<int>> execute(DeleteRecurringTaskRequest request) async {
    return safeExecute(request, () async {
      final result = await _recurringTaskRepository.deleteRecurringTask(
        request.id,
      );
      return result;
    });
  }
}
