import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/domain/usecases/account/createAccount/create_account_request.dart';
import 'package:eling_app/domain/usecases/account/createAccount/create_account_usecase.dart';
import 'package:eling_app/domain/usecases/account/deleteAccount/delete_account_request.dart';
import 'package:eling_app/domain/usecases/account/deleteAccount/delete_account_usecase.dart';
import 'package:eling_app/domain/usecases/account/getAccounts/get_accounts_request.dart';
import 'package:eling_app/domain/usecases/account/getAccounts/get_accounts_usecase.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_account_name.dart';
import 'package:eling_app/presentation/pages/finance/notifier/finance_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

mixin AccountMixin on StateNotifier<FinanceState> {
  CreateAccountUseCase get createAccountUseCase;
  GetAccountsUseCase get getAccountsUseCase;
  DeleteAccountUseCase get deleteAccountUseCase;

  Future<void> getAccounts() async {
    state = state.copyWith(accounts: const Resource.loading());

    final result = await getAccountsUseCase.execute(const GetAccountsRequest());

    result.when(
      success: (accounts) {
        state = state.copyWith(accounts: Resource.success(accounts));
      },
      failure: (error) {
        state = state.copyWith(accounts: Resource.failure(error));
      },
    );
  }

  Future<void> createAccount(AccountType type) async {
    state = state.copyWith(saveResult: const Resource.loading());

    final account = AccountEntity(
      id: const Uuid().v4(),
      name: state.accountName.value,
      type: type,
      balance: 0,
      createdAt: DateTime.now(),
    );

    final result = await createAccountUseCase.execute(
      CreateAccountRequest(account: account),
    );

    result.when(
      success: (_) {
        resetAccountForm();
        getAccounts();
        state = state.copyWith(saveResult: Resource.success('account'));
      },
      failure: (_) {
        state = state.copyWith(saveResult: Resource.failure('account'));
      },
    );
  }

  Future<void> deleteAccount(String id) async {
    final result = await deleteAccountUseCase.execute(
      DeleteAccountRequest(id: id),
    );

    result.when(
      success: (_) {
        getAccounts();
        state = state.copyWith(deleteResult: Resource.success('account'));
      },
      failure: (_) {
        state = state.copyWith(deleteResult: Resource.failure('account'));
      },
    );
  }

  void accountNameChanged(String value) {
    final accountName = FinanceAccountNameInput.dirty(value: value);
    final isValid = accountName.isValid;

    state = state.copyWith(
      accountName: accountName,
      isAccountFormValid: isValid,
    );
  }

  void resetAccountForm() {
    final account = FinanceAccountNameInput.pure();
    state = state.copyWith(accountName: account, isAccountFormValid: false);
  }
}
