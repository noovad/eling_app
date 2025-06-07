import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/transaction_repository.dart';
import 'package:eling/domain/entities/transaction/transaction.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/transaction/getTransactionsByYear/get_monthly_summary_for_year_request.dart';

abstract class GetMonthlySummaryForYearUseCase {
  Future<Result<Map<int, List<TransactionEntity>>>> execute(
    GetMonthlySummaryForYearRequest request,
  );
}

class GetMonthlySummaryForYearUseCaseImpl
    extends
        BaseUsecase<
          GetMonthlySummaryForYearRequest,
          Map<int, List<TransactionEntity>>
        >
    implements GetMonthlySummaryForYearUseCase {
  final TransactionRepository _repository;

  @override
  String get usecaseName => 'GetMonthlySummaryForYearUseCase';

  GetMonthlySummaryForYearUseCaseImpl({
    required super.logger,
    required TransactionRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<Map<int, List<TransactionEntity>>>> execute(
    GetMonthlySummaryForYearRequest request,
  ) {
    return safeExecute(request, () async {
      final transactions = await _repository.getMonthlySummaryForYear(
        request.year,
      );
      return transactions;
    });
  }
}
