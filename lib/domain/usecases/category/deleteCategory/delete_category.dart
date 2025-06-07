import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/category_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/category/deleteCategory/delete_category_request.dart';

abstract class DeleteCategoryUseCase {
  Future<Result<int>> execute(DeleteCategoryRequest request);
}

class DeleteCategoryUseCaseImpl extends BaseUsecase<DeleteCategoryRequest, int>
    implements DeleteCategoryUseCase {
  final CategoryRepository _categoryRepository;
  @override
  String get usecaseName => 'DeleteCategoryUseCase';

  DeleteCategoryUseCaseImpl({
    required super.logger,
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  @override
  Future<Result<int>> execute(DeleteCategoryRequest request) async {
    return safeExecute(request, () async {
      final result = await _categoryRepository.deleteCategory(request.id);
      return result;
    });
  }
}
