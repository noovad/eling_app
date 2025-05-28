import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/recurring_task_repository.dart';
import 'package:eling_app/domain/entities/recurringTask/recurring_task.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/recurringTask/createRecurringTask/create_recurring_task_request.dart';

abstract class CreateRecurringTaskUseCase {
  Future<Result<RecurringTaskEntity>> execute(
    CreateRecurringTaskRequest request,
  );
}

class CreateRecurringTaskUseCaseImpl
    extends BaseUsecase<CreateRecurringTaskRequest, RecurringTaskEntity>
    implements CreateRecurringTaskUseCase {
  final RecurringTaskRepository _recurringTaskRepository;
  @override
  String get usecaseName => 'CreateRecurringTaskUseCase';

  CreateRecurringTaskUseCaseImpl({
    required super.logger,
    required RecurringTaskRepository recurringTaskRepository,
  }) : _recurringTaskRepository = recurringTaskRepository;

  @override
  Future<Result<RecurringTaskEntity>> execute(
    CreateRecurringTaskRequest request,
  ) async {
    return safeExecute(request, () async {
      final result = await _recurringTaskRepository.createRecurringTask(
        request.recurringTask,
      );
      return result;
    });
  }
}
