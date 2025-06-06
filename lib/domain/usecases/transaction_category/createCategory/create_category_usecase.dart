import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/transaction_category_repository.dart';
import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/createCategory/create_category_request.dart';

abstract class CreateCategoryUseCase {
  Future<Result<TransactionCategoryEntity>> execute(
    CreateCategoryRequest request,
  );
}

class CreateCategoryUseCaseImpl
    extends BaseUsecase<CreateCategoryRequest, TransactionCategoryEntity>
    implements CreateCategoryUseCase {
  final TransactionCategoryRepository _repository;

  @override
  String get usecaseName => 'CreateCategoryUseCase';

  CreateCategoryUseCaseImpl({
    required super.logger,
    required TransactionCategoryRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<TransactionCategoryEntity>> execute(
    CreateCategoryRequest request,
  ) {
    return safeExecute(request, () async {
      final category = await _repository.createCategory(request.category);
      return category;
    });
  }
}
