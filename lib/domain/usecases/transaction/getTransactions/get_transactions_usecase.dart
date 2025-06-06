import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/transaction_repository.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/getTransactions/get_transactions_request.dart';

abstract class GetTransactionsUseCase {
  Future<Result<List<TransactionEntity>>> execute(
    GetTransactionsRequest request,
  );
}

class GetTransactionsUseCaseImpl
    extends BaseUsecase<GetTransactionsRequest, List<TransactionEntity>>
    implements GetTransactionsUseCase {
  final TransactionRepository _repository;

  @override
  String get usecaseName => 'GetTransactionsUseCase';

  GetTransactionsUseCaseImpl({
    required super.logger,
    required TransactionRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<List<TransactionEntity>>> execute(
    GetTransactionsRequest request,
  ) {
    return safeExecute(request, () async {
      final transactions = await _repository.getTransactions(
        month: request.month,
        year: request.year,
        type: request.type,
      );
      return transactions;
    });
  }
}
