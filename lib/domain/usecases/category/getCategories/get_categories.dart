import 'package:eling_app/core/enum/category_type.dart';
import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/domain/entities/category/category.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories_request.dart';

abstract class GetCategoriesUseCase {
  Future<Result<List<CategoryEntity>>> execute(GetCategoriesRequest request);
}

class GetCategoriesUseCaseImpl
    extends BaseUsecase<GetCategoriesRequest, List<CategoryEntity>>
    implements GetCategoriesUseCase {
  @override
  String get usecaseName => 'GetCategoriesUseCase';

  GetCategoriesUseCaseImpl({required super.logger});

  @override
  Future<Result<List<CategoryEntity>>> execute(
    GetCategoriesRequest request,
  ) async {
    return safeExecute(request, () async {
      await Future.delayed(const Duration(seconds: 2));
      switch (request.categoryType) {
        case CategoryType.daily:
          return [
            CategoryEntity(name: 'Daily'),
            CategoryEntity(name: 'Personal'),
            CategoryEntity(name: 'Urgent'),
            CategoryEntity(name: 'Shopping'),
          ];
        case CategoryType.productivity:
          return [
            CategoryEntity(name: 'Productivity'),
            CategoryEntity(name: 'Personal'),
            CategoryEntity(name: 'Urgent'),
            CategoryEntity(name: 'Shopping'),
          ];
        case CategoryType.note:
          return [
            CategoryEntity(name: 'Note'),
            CategoryEntity(name: 'Personal'),
            CategoryEntity(name: 'Urgent'),
            CategoryEntity(name: 'Shopping'),
          ];
      }
    });
  }
}
