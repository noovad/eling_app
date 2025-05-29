import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/category_repository.dart';
import 'package:eling_app/domain/entities/category/category.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/category/createCategory/create_category_request.dart';

abstract class CreateCategoryUseCase {
  Future<Result<CategoryEntity>> execute(CreateCategoryRequest request);
}

class CreateCategoryUseCaseImpl extends BaseUsecase<CreateCategoryRequest, CategoryEntity>
    implements CreateCategoryUseCase {
  final CategoryRepository _categoryRepository;
  @override
  String get usecaseName => 'CreateCategoryUseCase';

  CreateCategoryUseCaseImpl({
    required super.logger,
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  @override
  Future<Result<CategoryEntity>> execute(CreateCategoryRequest request) async {
    return safeExecute(request, () async {
      final result = await _categoryRepository.createCategory(request.category);
      return result;
    });
  }
}
