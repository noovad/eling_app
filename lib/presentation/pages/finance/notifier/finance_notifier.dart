import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/domain/entities/finance_summary/finance_summary.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';
import 'package:eling_app/domain/usecases/account/createAccount/create_account_usecase.dart';
import 'package:eling_app/domain/usecases/account/deleteAccount/delete_account_usecase.dart';
import 'package:eling_app/domain/usecases/account/getAccounts/get_accounts_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/createTransaction/create_transaction_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/deleteTransaction/delete_transaction_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/getFinanceSummary/get_finance_summary_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/getTransactions/get_transactions_usecase.dart';
import 'package:eling_app/domain/usecases/transaction/getTransactionsByYear/get_monthly_summary_for_year_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/createCategory/create_category_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/deleteCategory/delete_category_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/getCategories/get_categories_usecase.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_account_name.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_amount.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_category.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_category_name.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_date.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_source.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_target.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_title.dart';
import 'package:eling_app/presentation/pages/finance/notifier/mixins/account_mixin.dart';
import 'package:eling_app/presentation/pages/finance/notifier/mixins/transaction_category_mixin.dart';
import 'package:eling_app/presentation/pages/finance/notifier/mixins/transaction_mixin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling_app/core/utils/resource.dart';

part 'finance_state.dart';
part 'finance_notifier.freezed.dart';

class FinanceNotifier extends StateNotifier<FinanceState>
    with TransactionMixin, TransactionCategoryMixin, AccountMixin {
  @override
  final GetTransactionsUseCase getTransactionsUseCase;
  @override
  final GetMonthlySummaryForYearUseCase getMonthlySummaryForYearUseCase;
  @override
  final GetFinanceSummaryUseCase getFinanceSummaryUseCase;
  @override
  final CreateTransactionUseCase createTransactionUseCase;
  @override
  final DeleteTransactionUseCase deleteTransactionUseCase;

  @override
  final CreateCategoryUseCase createCategoryUseCase;
  @override
  final GetCategoriesUseCase getCategoriesUseCase;
  @override
  final DeleteCategoryUseCase deleteCategoryUseCase;

  @override
  final CreateAccountUseCase createAccountUseCase;
  @override
  final GetAccountsUseCase getAccountsUseCase;
  @override
  final DeleteAccountUseCase deleteAccountUseCase;

  FinanceNotifier({
    required this.getTransactionsUseCase,
    required this.getMonthlySummaryForYearUseCase,
    required this.getFinanceSummaryUseCase,
    required this.createTransactionUseCase,
    required this.deleteTransactionUseCase,
    required this.createCategoryUseCase,
    required this.getCategoriesUseCase,
    required this.deleteCategoryUseCase,
    required this.createAccountUseCase,
    required this.getAccountsUseCase,
    required this.deleteAccountUseCase,
  }) : super(FinanceState.initial()) {
    getTransactions();
    getMonthlySummaryForYear();
    getFinanceSummary();
    getTransactionCategories();
    getAccounts();
  }
}
