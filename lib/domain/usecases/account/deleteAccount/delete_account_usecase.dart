import 'package:eling/core/utils/result.dart';
import 'package:eling/data/repositories/account_repository.dart';
import 'package:eling/domain/usecases/base_usecase.dart';
import 'package:eling/domain/usecases/account/deleteAccount/delete_account_request.dart';

abstract class DeleteAccountUseCase {
  Future<Result<bool>> execute(DeleteAccountRequest request);
}

class DeleteAccountUseCaseImpl extends BaseUsecase<DeleteAccountRequest, bool>
    implements DeleteAccountUseCase {
  final AccountRepository _repository;

  @override
  String get usecaseName => 'DeleteAccountUseCase';

  DeleteAccountUseCaseImpl({
    required super.logger,
    required AccountRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> execute(DeleteAccountRequest request) {
    return safeExecute(request, () async {
      final result = await _repository.deleteAccount(request.id);
      return result > 0;
    });
  }
}
