import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/account_repository.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/account/getAccounts/get_accounts_request.dart';

abstract class GetAccountsUseCase {
  Future<Result<List<AccountEntity>>> execute(GetAccountsRequest request);
}

class GetAccountsUseCaseImpl
    extends BaseUsecase<GetAccountsRequest, List<AccountEntity>>
    implements GetAccountsUseCase {
  final AccountRepository _repository;

  @override
  String get usecaseName => 'GetAccountsUseCase';

  GetAccountsUseCaseImpl({
    required super.logger,
    required AccountRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<List<AccountEntity>>> execute(GetAccountsRequest request) {
    return safeExecute(request, () async {
      final accounts = await _repository.getAccounts();
      return accounts;
    });
  }
}
