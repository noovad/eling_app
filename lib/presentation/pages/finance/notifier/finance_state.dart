part of 'finance_notifier.dart';

@freezed
abstract class FinanceState with _$FinanceState {
  const factory FinanceState({
    // Transaction form fields
    @Default(FinanceTitleInput.pure()) FinanceTitleInput transactionTitle,
    @Default(FinanceAmountInput.pure()) FinanceAmountInput amount,
    @Default(FinanceDateInput.pure()) FinanceDateInput date,
    @Default(FinanceSourceInput.pure()) FinanceSourceInput source,
    @Default(FinanceTargetInput.pure()) FinanceTargetInput target,
    @Default(FinanceCategoryInput.pure()) FinanceCategoryInput category,
    @Default('') String description,
    @Default(TransactionType.expense) TransactionType transactionType,
    @Default(false) bool isFormValid,

    // Transaction related resources
    @Default(Resource.initial())
    Resource<List<TransactionEntity>> monthlyTransactions,
    @Default(Resource.initial())
    Resource<Map<int, List<TransactionEntity>>> yearlyTransactions,
    @Default(Resource.initial()) Resource<FinanceSummaryEntity> financeSummary,
    @Default(Resource.initial())
    Resource<TransactionEntity> createTransactionResult,

    // Transaction category fields
    @Default('') String newCategoryName,
    @Default(Resource.initial())
    Resource<List<TransactionCategoryEntity>> transactionCategories,
    @Default(Resource.initial())
    Resource<TransactionCategoryEntity> createTransactionCategoryResult,

    // Account fields
    @Default('') String newAccountTitle,
    @Default(AccountType.balance) AccountType newAccountType,
    @Default(0.0) double newAccountBalance,
    @Default(Resource.initial()) Resource<List<AccountEntity>> accounts,
    @Default(Resource.initial()) Resource<AccountEntity> createAccountResult,

    // Filter parameters
    required DateTime dateFilter,
    TransactionType? filterType,

    // Legacy fields (keep for backward compatibility)
    @Default(Resource.initial()) Resource<String> title,
    @Default('') String name,
  }) = _FinanceState;

  factory FinanceState.initial() =>
      FinanceState(dateFilter: DateTime.now(), title: Resource.initial());
}
