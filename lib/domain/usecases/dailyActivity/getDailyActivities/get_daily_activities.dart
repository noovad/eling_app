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
      final result = await _taskRepository.getDailyActivities(month: request.month, year: request.year);
      if (result.isEmpty) {
        return [];
      }
      return result;
      // await Future.delayed(const Duration(seconds: 2));
      // final List<DailyActivityEntity> may = List.generate(31, (index) {
      //   final date = DateTime(DateTime.now().year, 5, index + 1);
      //   return DailyActivityEntity(
      //     date: date,
      //     sholat: (index % 6),
      //     gym: true,
      //     cardio: true,
      //     coding: true,
      //     amount: 5,
      //     calorieControlled: index % 2 == 0,
      //   );
      // });
      // final List<DailyActivityEntity> jun = List.generate(31, (index) {
      //   final date = DateTime(DateTime.now().year, 6, index + 1);
      //   return DailyActivityEntity(
      //     date: date,
      //     sholat: (index % 6),
      //     gym: true,
      //     cardio: true,
      //     coding: true,
      //     amount: 6,
      //     calorieControlled: index % 2 == 0,
      //   );
      // });
      // if (request.month == 5 && request.year == DateTime.now().year) {
      //   return may;
      // } else if (request.month == 6 && request.year == DateTime.now().year) {
      //   return jun;
      // }
      // return [];
    });
  }
}
