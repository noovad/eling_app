import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:eling_app/domain/entities/dailyActivity/daily_activity.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/dailyActivity/getDailyActivities/get_daily_activities_request.dart';

abstract class GetDailyActivitiesUseCase {
  Future<Result<List<DailyActivityEntity>>> execute(
    GetDailyActivitiesRequest request,
  );
}

class GetDailyActivitiesUseCaseImpl
    extends BaseUsecase<GetDailyActivitiesRequest, List<DailyActivityEntity>>
    implements GetDailyActivitiesUseCase {
  final TaskRepository _taskRepository;
  @override
  String get usecaseName => 'GetDailyActivitiesUseCase';

  GetDailyActivitiesUseCaseImpl({
    required super.logger,
    required TaskRepository taskRepository,
  }) : _taskRepository = taskRepository;

  @override
  Future<Result<List<DailyActivityEntity>>> execute(
    GetDailyActivitiesRequest request,
  ) async {
    return safeExecute(request, () async {
      final result = await _taskRepository.getDailyActivities(
        month: request.month,
        year: request.year,
      );
      return result;
    });
  }
}
