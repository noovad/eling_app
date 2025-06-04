import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/transaction_repository.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/getTransactionsByYear/get_transactions_by_year_request.dart';

abstract class GetTransactionsByYearUseCase {
  Future<Result<Map<int, List<TransactionEntity>>>> execute(
    GetTransactionsByYearRequest request,
  );
}

class GetTransactionsByYearUseCaseImpl
    extends
        BaseUsecase<
          GetTransactionsByYearRequest,
          Map<int, List<TransactionEntity>>
        >
    implements GetTransactionsByYearUseCase {
  final TransactionRepository _repository;

  @override
  String get usecaseName => 'GetTransactionsByYearUseCase';

  GetTransactionsByYearUseCaseImpl({
    required super.logger,
    required TransactionRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<Map<int, List<TransactionEntity>>>> execute(
    GetTransactionsByYearRequest request,
  ) {
    return safeExecute(request, () async {
      final transactions = await _repository.getTransactionsByMonthInYear(
        request.year,
      );
      return transactions;
    });
  }
}
