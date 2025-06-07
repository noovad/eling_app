import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/recurring_task_repository.dart';
import 'package:eling/domain/entities/recurringTaskGroupResult/recurring_task_group_result.dart';
import 'package:eling/domain/usecases/base_usecase.dart';

abstract class GetRecurringTasksUseCase {
  Future<Result<RecurringTaskGroupResultEntity>> execute(NoRequest request);
}

class GetRecurringTasksUseCaseImpl
    extends BaseUsecase<NoRequest, RecurringTaskGroupResultEntity>
    implements GetRecurringTasksUseCase {
  final RecurringTaskRepository _recurringTaskRepository;
  @override
  String get usecaseName => 'GetRecurringTasksUseCase';

  GetRecurringTasksUseCaseImpl({
    required super.logger,
    required RecurringTaskRepository recurringTaskRepository,
  }) : _recurringTaskRepository = recurringTaskRepository;

  @override
  Future<Result<RecurringTaskGroupResultEntity>> execute(
    NoRequest request,
  ) async {
    return safeExecute(request, () async {
      final result = await _recurringTaskRepository.getTasks();
      return result;
    });
  }
}
