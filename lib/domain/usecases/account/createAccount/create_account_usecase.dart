import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/data/repositories/account_repository.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/account/createAccount/create_account_request.dart';

abstract class CreateAccountUseCase {
  Future<Result<AccountEntity>> execute(CreateAccountRequest request);
}

class CreateAccountUseCaseImpl
    extends BaseUsecase<CreateAccountRequest, AccountEntity>
    implements CreateAccountUseCase {
  final AccountRepository _repository;

  @override
  String get usecaseName => 'CreateAccountUseCase';

  CreateAccountUseCaseImpl({
    required super.logger,
    required AccountRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<AccountEntity>> execute(CreateAccountRequest request) {
    return safeExecute(request, () async {
      final account = await _repository.createAccount(request.account);
      return account;
    });
  }
}
