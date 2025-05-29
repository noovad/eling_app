import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/category_repository.dart';
import 'package:eling_app/domain/entities/category/category.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/category/getCategories/get_categories_request.dart';

abstract class GetCategoriesUseCase {
  Future<Result<List<CategoryEntity>>> execute(GetCategoriesRequest request);
}

class GetCategoriesUseCaseImpl
    extends BaseUsecase<GetCategoriesRequest, List<CategoryEntity>>
    implements GetCategoriesUseCase {
  final CategoryRepository _categoryRepository;
  @override
  String get usecaseName => 'GetCategoriesUseCase';

  GetCategoriesUseCaseImpl({
    required super.logger,
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  @override
  Future<Result<List<CategoryEntity>>> execute(
    GetCategoriesRequest request,
  ) async {
    return safeExecute(request, () async {
      final result = await _categoryRepository.readAllCategories(
        type: request.categoryType.name,
      );
      return result;
    });
  }
}
