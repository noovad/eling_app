import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/domain/entities/dailyActivity/daily_activity.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';

abstract class GetDailyActivitiesUseCase {
  Future<Result<List<DailyActivityEntity>>> execute(NoRequest request);
}

class GetDailyActivitiesUseCaseImpl
    extends BaseUsecase<NoRequest, List<DailyActivityEntity>>
    implements GetDailyActivitiesUseCase {
  @override
  String get usecaseName => 'GetDailyActivitiesUseCase';

  GetDailyActivitiesUseCaseImpl({required super.logger});

  @override
  Future<Result<List<DailyActivityEntity>>> execute(NoRequest request) async {
    return safeExecute(request, () async {
      final List<DailyActivityEntity> dailyActivities = List.generate(31, (
        index,
      ) {
        final date = DateTime(DateTime.now().year, 5, index + 1);
        return DailyActivityEntity(
          date: date,
          sholat: (index % 6),
          gym: true,
          cardio: true,
          coding: true,
          amount: 0,
          calorieControlled: index % 2 == 0,
        );
      });
      return dailyActivities;
    });
  }
}
