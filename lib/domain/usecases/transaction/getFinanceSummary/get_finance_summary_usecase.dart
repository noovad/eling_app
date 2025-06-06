import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/transaction_repository.dart';
import 'package:eling_app/domain/entities/finance_summary/finance_summary.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/getFinanceSummary/get_finance_summary_request.dart';

abstract class GetFinanceSummaryUseCase {
  Future<Result<FinanceSummaryEntity>> execute(
    GetFinanceSummaryRequest request,
  );
}

class GetFinanceSummaryUseCaseImpl
    extends BaseUsecase<GetFinanceSummaryRequest, FinanceSummaryEntity>
    implements GetFinanceSummaryUseCase {
  final TransactionRepository _repository;

  @override
  String get usecaseName => 'GetFinanceSummaryUseCase';

  GetFinanceSummaryUseCaseImpl({
    required super.logger,
    required TransactionRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<FinanceSummaryEntity>> execute(
    GetFinanceSummaryRequest request,
  ) {
    return safeExecute(request, () async {
      final summary = await _repository.getFinanceSummary(
        month: request.month,
        year: request.year,
      );
      return summary;
    });
  }
}
