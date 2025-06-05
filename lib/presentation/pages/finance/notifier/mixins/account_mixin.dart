import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/domain/usecases/account/createAccount/create_account_request.dart';
import 'package:eling_app/domain/usecases/account/createAccount/create_account_usecase.dart';
import 'package:eling_app/domain/usecases/account/deleteAccount/delete_account_request.dart';
import 'package:eling_app/domain/usecases/account/deleteAccount/delete_account_usecase.dart';
import 'package:eling_app/domain/usecases/account/getAccounts/get_accounts_request.dart';
import 'package:eling_app/domain/usecases/account/getAccounts/get_accounts_usecase.dart';
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

  Future<void> createAccount(String title, AccountType type) async {
    state = state.copyWith(createAccountResult: const Resource.loading());

    final account = AccountEntity(
      id: const Uuid().v4(),
      title: title,
      type: type,
      balance: 0,
      createdAt: DateTime.now(),
    );

    final result = await createAccountUseCase.execute(
      CreateAccountRequest(account: account),
    );

    result.when(
      success: (createdAccount) {
        state = state.copyWith(
          createAccountResult: Resource.success(createdAccount),
        );
        getAccounts();
        resetAccountForm();
      },
      failure: (error) {
        print('Error creating account: $error');
        state = state.copyWith(createAccountResult: Resource.failure(error));
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
      },
      failure: (_) {},
    );
  }

  void updateNewAccountTitle(String value) {
    state = state.copyWith(newAccountTitle: value);
  }

  void updateNewAccountType(AccountType type) {
    state = state.copyWith(newAccountType: type);
  }

  void updateNewAccountBalance(double value) {
    state = state.copyWith(newAccountBalance: value);
  }

  bool isAccountFormValid() {
    return state.newAccountTitle.isNotEmpty;
  }

  void resetAccountForm() {
    state = state.copyWith(
      newAccountTitle: '',
      newAccountType: AccountType.balance,
      newAccountBalance: 0.0,
      createAccountResult: const Resource.initial(),
    );
  }
}
