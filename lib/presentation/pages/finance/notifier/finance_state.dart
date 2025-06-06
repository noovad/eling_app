part of 'finance_notifier.dart';

@freezed
abstract class FinanceState with _$FinanceState {
  const factory FinanceState({
    // Resources
    @Default(Resource.initial())
    Resource<List<TransactionEntity>> monthlyTransactions,
    @Default(Resource.initial())
    Resource<Map<int, List<TransactionEntity>>> yearlyTransactions,
    @Default(Resource.initial()) Resource<FinanceSummaryEntity> financeSummary,
    @Default(Resource.initial()) Resource<List<AccountEntity>> accounts,
    @Default(Resource.initial())
    Resource<List<TransactionCategoryEntity>> transactionCategories,

    // Transaction form fields
    @Default(TransactionType.income) TransactionType transactionType,
    @Default(FinanceTitleInput.pure()) FinanceTitleInput transactionTitle,
    @Default(FinanceAmountInput.pure()) FinanceAmountInput amount,
    @Default(FinanceDateInput.pure()) FinanceDateInput date,
    @Default(FinanceCategoryInput.pure()) FinanceCategoryInput category,
    @Default(FinanceSourceInput.pure()) FinanceSourceInput source,
    @Default(FinanceTargetInput.pure()) FinanceTargetInput target,
    @Default('') String description,
    @Default(false) bool isFormValid,

    // Transaction category fields
    @Default(FinanceCategoryNameInput.pure())
    FinanceCategoryNameInput categoryName,
    @Default(false) bool isCategoryFormValid,

    // Account fields
    @Default(FinanceAccountNameInput.pure())
    FinanceAccountNameInput accountName,
    @Default(AccountType.balance) AccountType acountType,
    @Default(false) bool isAccountFormValid,

    // Result
    required Resource<String> saveResult,
    required Resource<String> updateResult,
    required Resource<String> deleteResult,

    // Filter parameters
    required DateTime dateFilter,
    required int yearFilter,
    TransactionType? filterType,
  }) = _FinanceState;

  factory FinanceState.initial() => FinanceState(
    dateFilter: DateTime.now(),
    yearFilter: DateTime.now().year,
    saveResult: Resource.initial(),
    updateResult: Resource.initial(),
    deleteResult: Resource.initial(),
  );
}
