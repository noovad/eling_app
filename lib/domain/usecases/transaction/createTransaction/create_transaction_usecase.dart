import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/transaction_repository.dart';
import 'package:eling/domain/entities/transaction/transaction.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/transaction/createTransaction/create_transaction_request.dart';

abstract class CreateTransactionUseCase {
  Future<Result<TransactionEntity>> execute(CreateTransactionRequest request);
}

class CreateTransactionUseCaseImpl
    extends BaseUsecase<CreateTransactionRequest, TransactionEntity>
    implements CreateTransactionUseCase {
  final TransactionRepository _repository;

  @override
  String get usecaseName => 'CreateTransactionUseCase';

  CreateTransactionUseCaseImpl({
    required super.logger,
    required TransactionRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<TransactionEntity>> execute(CreateTransactionRequest request) {
    return safeExecute(request, () async {
      final transaction = await _repository.createTransaction(
        request.transaction,
      );
      return transaction;
    });
  }
}
