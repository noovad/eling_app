import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/createCategory/create_category_request.dart';
import 'package:eling_app/domain/usecases/transaction_category/createCategory/create_category_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/deleteCategory/delete_category_request.dart';
import 'package:eling_app/domain/usecases/transaction_category/deleteCategory/delete_category_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/getCategories/get_categories_usecase.dart';
import 'package:eling_app/presentation/pages/finance/models/finance_category_name.dart';
import 'package:eling_app/presentation/pages/finance/notifier/finance_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

mixin TransactionCategoryMixin on StateNotifier<FinanceState> {
  CreateCategoryUseCase get createCategoryUseCase;
  GetCategoriesUseCase get getCategoriesUseCase;
  DeleteCategoryUseCase get deleteCategoryUseCase;

  Future<void> getTransactionCategories() async {
    state = state.copyWith(transactionCategories: const Resource.loading());

    final result = await getCategoriesUseCase.execute(NoRequest());

    result.when(
      success: (categories) {
        state = state.copyWith(
          transactionCategories: Resource.success(categories),
        );
      },
      failure: (error) {
        state = state.copyWith(transactionCategories: Resource.failure(error));
      },
    );
  }

  Future<void> createTransactionCategory(String name) async {
    state = state.copyWith(saveResult: const Resource.loading());

    final category = TransactionCategoryEntity(
      id: const Uuid().v4(),
      name: name,
    );

    final result = await createCategoryUseCase.execute(
      CreateCategoryRequest(category: category),
    );

    result.when(
      success: (_) {
        getTransactionCategories();
        resetCategoryForm();
        state = state.copyWith(saveResult: Resource.success('category'));
      },
      failure: (_) {
        state = state.copyWith(saveResult: Resource.failure('category'));
      },
    );
  }

  Future<void> deleteTransactionCategory(String id) async {
    final result = await deleteCategoryUseCase.execute(
      DeleteCategoryRequest(id: id),
    );

    result.when(
      success: (_) {
        getTransactionCategories();
        state = state.copyWith(
          deleteResult: Resource.success('category'),
        );
      },
      failure: (_) {
        state = state.copyWith(
          deleteResult: Resource.failure('category'),
        );

      },
    );
  }

  void categoryNameChanged(String value) {
    final name = FinanceCategoryNameInput.dirty(value: value);
    final isValid = name.isValid;
    state = state.copyWith(categoryName: name, isCategoryFormValid: isValid);
  }

  void resetCategoryForm() {
    state = state.copyWith(
      categoryName: const FinanceCategoryNameInput.pure(),
      isCategoryFormValid: false,
    );
  }
}
