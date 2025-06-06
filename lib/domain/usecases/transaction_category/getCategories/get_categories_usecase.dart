import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/transaction_category_repository.dart';
import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';

abstract class GetCategoriesUseCase {
  Future<Result<List<TransactionCategoryEntity>>> execute(NoRequest request);
}

class GetCategoriesUseCaseImpl
    extends BaseUsecase<NoRequest, List<TransactionCategoryEntity>>
    implements GetCategoriesUseCase {
  final TransactionCategoryRepository _repository;

  @override
  String get usecaseName => 'GetCategoriesUseCase';

  GetCategoriesUseCaseImpl({
    required super.logger,
    required TransactionCategoryRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<List<TransactionCategoryEntity>>> execute(NoRequest request) {
    return safeExecute(request, () async {
      final categories = await _repository.getCategories();
      return categories;
    });
  }
}
