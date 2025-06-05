import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/transaction_repository.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/deleteTransaction/delete_transaction_request.dart';

abstract class DeleteTransactionUseCase {
  Future<Result<bool>> execute(DeleteTransactionRequest request);
}

class DeleteTransactionUseCaseImpl
    extends BaseUsecase<DeleteTransactionRequest, bool>
    implements DeleteTransactionUseCase {
  final TransactionRepository _repository;

  @override
  String get usecaseName => 'DeleteTransactionUseCase';

  DeleteTransactionUseCaseImpl({
    required super.logger,
    required TransactionRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> execute(DeleteTransactionRequest request) {
    return safeExecute(request, () async {
      final result = await _repository.deleteTransaction(request.id);
      return result > 0;
    });
  }
}
