import 'package:eling_app/core/providers/usecase/account/createAccount/create_account_provider.dart';
import 'package:eling_app/core/providers/usecase/account/deleteAccount/delete_account_provider.dart';
import 'package:eling_app/core/providers/usecase/account/getAccounts/get_accounts_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction/createTransaction/create_transaction_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction/deleteTransaction/delete_transaction_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction/getFinanceSummary/get_finance_summary_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction/getTransactions/get_transactions_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction_category/createCategory/create_category_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction_category/deleteCategory/delete_category_provider.dart';
import 'package:eling_app/core/providers/usecase/transaction_category/getCategories/get_categories_provider.dart';
import 'package:eling_app/presentation/pages/finance/notifier/finance_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final financeNotifierProvider =
    StateNotifierProvider<FinanceNotifier, FinanceState>((ref) {
      return FinanceNotifier(
        getTransactionsUseCase: ref.watch(getTransactionsUseCaseProvider),
        getFinanceSummaryUseCase: ref.watch(getFinanceSummaryUseCaseProvider),
        createTransactionUseCase: ref.watch(createTransactionUseCaseProvider),
        deleteTransactionUseCase: ref.watch(deleteTransactionUseCaseProvider),
        getAccountsUseCase: ref.watch(getAccountsUseCaseProvider),
        deleteAccountUseCase: ref.watch(deleteAccountUseCaseProvider),
        createAccountUseCase: ref.watch(createAccountUseCaseProvider),
        createCategoryUseCase: ref.watch(createCategoryUseCaseProvider),
        getCategoriesUseCase: ref.watch(getCategoriesUseCaseProvider),
        deleteCategoryUseCase: ref.watch(deleteCategoryUseCaseProvider),
      );
    });
