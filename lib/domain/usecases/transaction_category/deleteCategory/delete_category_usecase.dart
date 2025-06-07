import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/transaction_category_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/transaction_category/deleteCategory/delete_category_request.dart';

abstract class DeleteCategoryUseCase {
  Future<Result<bool>> execute(DeleteCategoryRequest request);
}

class DeleteCategoryUseCaseImpl extends BaseUsecase<DeleteCategoryRequest, bool>
    implements DeleteCategoryUseCase {
  final TransactionCategoryRepository _repository;

  @override
  String get usecaseName => 'DeleteCategoryUseCase';

  DeleteCategoryUseCaseImpl({
    required super.logger,
    required TransactionCategoryRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> execute(DeleteCategoryRequest request) {
    return safeExecute(request, () async {
      final result = await _repository.deleteCategory(request.id);
      return result > 0;
    });
  }
}
