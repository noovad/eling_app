import 'package:eling/core/enum/transaction_type.dart';
import 'package:eling/core/utils/constants/string_constants.dart';
import 'package:eling/core/utils/resource.dart';
import 'package:eling/domain/entities/transaction/transaction.dart';
import 'package:eling/domain/usecases/transaction/createTransaction/create_transaction_request.dart';
import 'package:eling/domain/usecases/transaction/createTransaction/create_transaction_usecase.dart';
import 'package:eling/domain/usecases/transaction/deleteTransaction/delete_transaction_request.dart';
import 'package:eling/domain/usecases/transaction/deleteTransaction/delete_transaction_usecase.dart';
import 'package:eling/domain/usecases/transaction/getFinanceSummary/get_finance_summary_request.dart';
import 'package:eling/domain/usecases/transaction/getFinanceSummary/get_finance_summary_usecase.dart';
import 'package:eling/domain/usecases/transaction/getTransactions/get_transactions_request.dart';
import 'package:eling/domain/usecases/transaction/getTransactions/get_transactions_usecase.dart';
import 'package:eling/domain/usecases/transaction/getTransactionsByYear/get_monthly_summary_for_year_request.dart';
import 'package:eling/domain/usecases/transaction/getTransactionsByYear/get_monthly_summary_for_year_usecase.dart';
import 'package:eling/presentation/pages/finance/models/finance_amount.dart';
import 'package:eling/presentation/pages/finance/models/finance_category.dart';
import 'package:eling/presentation/pages/finance/models/finance_date.dart';
import 'package:eling/presentation/pages/finance/models/finance_source.dart';
import 'package:eling/presentation/pages/finance/models/finance_target.dart';
import 'package:eling/presentation/pages/finance/models/finance_title.dart';
import 'package:eling/presentation/pages/finance/notifier/finance_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

mixin TransactionMixin on StateNotifier<FinanceState> {
  GetTransactionsUseCase get getTransactionsUseCase;
  GetMonthlySummaryForYearUseCase get getMonthlySummaryForYearUseCase;
  GetFinanceSummaryUseCase get getFinanceSummaryUseCase;
  CreateTransactionUseCase get createTransactionUseCase;
  DeleteTransactionUseCase get deleteTransactionUseCase;

  void getTransactions() async {
    final result = await getTransactionsUseCase.execute(
      GetTransactionsRequest(
        month: state.dateFilter.month,
        year: state.dateFilter.year,
        type: state.filterType,
      ),
    );

    result.when(
      success: (transactions) {
        state = state.copyWith(
          monthlyTransactions: Resource.success(transactions),
        );
      },
      failure: (error) {
        state = state.copyWith(monthlyTransactions: Resource.failure(error));
      },
    );
  }

  void getMonthlySummaryForYear() async {
    final result = await getMonthlySummaryForYearUseCase.execute(
      GetMonthlySummaryForYearRequest(year: state.yearFilter),
    );

    result.when(
      success: (summary) {
        state = state.copyWith(yearlyTransactions: Resource.success(summary));
      },
      failure: (error) {
        state = state.copyWith(yearlyTransactions: Resource.failure(error));
      },
    );
  }

  void getFinanceSummary() async {
    final result = await getFinanceSummaryUseCase.execute(
      GetFinanceSummaryRequest(
        month: state.dateFilter.month,
        year: state.dateFilter.year,
      ),
    );

    result.when(
      success: (summary) {
        state = state.copyWith(financeSummary: Resource.success(summary));
      },
      failure: (error) {
        state = state.copyWith(financeSummary: Resource.failure(error));
      },
    );
  }

  void updateFilter({DateTime? date, TransactionType? type}) {
    final prevType = state.filterType;

    if (date != null) {
      state = state.copyWith(dateFilter: date);
      getTransactions();
      getFinanceSummary();
    }

    if (type != null && type != prevType) {
      state = state.copyWith(filterType: type);
      getTransactions();
    } else if (type == null && prevType != null && date == null) {
      state = state.copyWith(filterType: null);
      getTransactions();
    }
  }

  void updateYearFilter(int year) {
    state = state.copyWith(yearFilter: year);
    getMonthlySummaryForYear();
  }

  void createTransaction() async {
    final transaction = TransactionEntity(
      id: const Uuid().v4(),
      type: state.transactionType,
      title: state.transactionTitle.value,
      date: DateTime.parse(state.date.value),
      amount: StringConstants.parseCurrencyToDouble(state.amount.value),
      category: state.category.value,
      source: state.source.value,
      target: state.target.value,
      description: state.description,
    );

    final result = await createTransactionUseCase.execute(
      CreateTransactionRequest(transaction: transaction),
    );

    result.when(
      success: (_) {
        getTransactions();
        getMonthlySummaryForYear();
        getFinanceSummary();
        state = state.copyWith(saveResult: Resource.success('transaction'));
      },
      failure: (a) {
        state = state.copyWith(saveResult: Resource.failure('transaction'));
      },
    );
  }

  void deleteTransaction(String id) async {
    final result = await deleteTransactionUseCase.execute(
      DeleteTransactionRequest(id: id),
    );

    result.when(
      success: (_) {
        getTransactions();
        getMonthlySummaryForYear();
        getFinanceSummary();
        state = state.copyWith(deleteResult: Resource.success('transaction'));
      },
      failure: (_) {
        state = state.copyWith(deleteResult: Resource.failure('transaction'));
      },
    );
  }

  void titleChanged(String value) {
    final title = FinanceTitleInput.dirty(value: value);
    state = state.copyWith(
      transactionTitle: title,
      isFormValid: _validateForm(title: title),
    );
  }

  void amountChanged(String value) {
    final amount = FinanceAmountInput.dirty(value: value);
    state = state.copyWith(
      amount: amount,
      isFormValid: _validateForm(amount: amount),
    );
  }

  void dateChanged(String value) {
    final date = FinanceDateInput.dirty(value: value);
    state = state.copyWith(date: date, isFormValid: _validateForm(date: date));
  }

  void sourceChanged(String value) {
    final source = FinanceSourceInput.dirty(value: value);
    state = state.copyWith(
      source: source,
      isFormValid: _validateForm(source: source),
    );
  }

  void targetChanged(String value) {
    final target = FinanceTargetInput.dirty(value: value);
    state = state.copyWith(
      target: target,
      isFormValid: _validateForm(target: target),
    );
  }

  void descriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  void categoryChanged(String value) {
    final category = FinanceCategoryInput.dirty(value: value);
    state = state.copyWith(
      category: category,
      isFormValid: _validateForm(category: category),
    );
  }

  void transactionTypeChanged(TransactionType type) {
    state = state.copyWith(
      transactionType: type,
      isFormValid: _validateForm(transactionType: type),
    );
  }

  bool _validateForm({
    TransactionType? transactionType,
    FinanceTitleInput? title,
    FinanceAmountInput? amount,
    FinanceDateInput? date,
    FinanceSourceInput? source,
    FinanceTargetInput? target,
    FinanceCategoryInput? category,
  }) {
    final titleInput = title ?? state.transactionTitle;
    final amountInput = amount ?? state.amount;
    final dateInput = date ?? state.date;
    final sourceInput = source ?? state.source;
    final targetInput = target ?? state.target;
    final type = transactionType ?? state.transactionType;
    final categoryInput = category ?? state.category;

    bool isValid = Formz.validate([titleInput, amountInput, dateInput]);

    switch (type) {
      case TransactionType.income:
        isValid = isValid && Formz.validate([targetInput]);
        break;
      case TransactionType.expense:
        isValid = isValid && Formz.validate([sourceInput, categoryInput]);
        break;
      case TransactionType.savings:
      case TransactionType.transfer:
      case TransactionType.withdraw:
        isValid = isValid && Formz.validate([sourceInput, targetInput]);
        break;
    }

    return isValid;
  }

  void resetTransactionForm() {
    state = state.copyWith(
      transactionTitle: const FinanceTitleInput.pure(),
      amount: const FinanceAmountInput.pure(),
      date: const FinanceDateInput.pure(),
      source: const FinanceSourceInput.pure(),
      category: const FinanceCategoryInput.pure(),
      target: const FinanceTargetInput.pure(),
      description: '',
      isFormValid: false,
      transactionType: TransactionType.income,
    );
  }

  void resetIsSaving() {
    state = state.copyWith(saveResult: Resource.initial());
  }

  void resetIsDeleting() {
    state = state.copyWith(deleteResult: Resource.initial());
  }
}
