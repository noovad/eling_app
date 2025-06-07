import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/recurring_task_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/recurringTask/updateRecurringTask/update_recurring_task_request.dart';

abstract class UpdateRecurringTaskUseCase {
  Future<Result<int>> execute(UpdateRecurringTaskRequest request);
}

class UpdateRecurringTaskUseCaseImpl
    extends BaseUsecase<UpdateRecurringTaskRequest, int>
    implements UpdateRecurringTaskUseCase {
  final RecurringTaskRepository _recurringTaskRepository;
  @override
  String get usecaseName => 'UpdateRecurringTaskUseCase';

  UpdateRecurringTaskUseCaseImpl({
    required super.logger,
    required RecurringTaskRepository recurringTaskRepository,
  }) : _recurringTaskRepository = recurringTaskRepository;

  @override
  Future<Result<int>> execute(UpdateRecurringTaskRequest request) async {
    return safeExecute(request, () async {
      final result = await _recurringTaskRepository.updateRecurringTask(
        request.recurringTask,
      );
      return result;
    });
  }
}
