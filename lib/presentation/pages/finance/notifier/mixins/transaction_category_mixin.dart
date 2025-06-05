import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/transaction_category/transaction_category.dart';
import 'package:eling_app/domain/usecases/transaction_category/createCategory/create_category_request.dart';
import 'package:eling_app/domain/usecases/transaction_category/createCategory/create_category_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/deleteCategory/delete_category_request.dart';
import 'package:eling_app/domain/usecases/transaction_category/deleteCategory/delete_category_usecase.dart';
import 'package:eling_app/domain/usecases/transaction_category/getCategories/get_categories_request.dart';
import 'package:eling_app/domain/usecases/transaction_category/getCategories/get_categories_usecase.dart';
import 'package:eling_app/presentation/pages/finance/notifier/finance_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

mixin TransactionCategoryMixin on StateNotifier<FinanceState> {
  CreateCategoryUseCase get createCategoryUseCase;
  GetCategoriesUseCase get getCategoriesUseCase;
  DeleteCategoryUseCase get deleteCategoryUseCase;
  
  Future<void> getTransactionCategories() async {
    state = state.copyWith(transactionCategories: const Resource.loading());
    
    final result = await getCategoriesUseCase.execute(
      const GetCategoriesRequest(),
    );
    
    result.when(
      success: (categories) {
        state = state.copyWith(
          transactionCategories: Resource.success(categories),
        );
      },
      failure: (error) {
        state = state.copyWith(
          transactionCategories: Resource.failure(error),
        );
      },
    );
  }
  
  Future<void> createTransactionCategory(String name) async {
    state = state.copyWith(
      createTransactionCategoryResult: const Resource.loading(),
    );
    
    final category = TransactionCategoryEntity(
      id: const Uuid().v4(),
      name: name,
    );
    
    final result = await createCategoryUseCase.execute(
      CreateCategoryRequest(category: category),
    );
    
    result.when(
      success: (createdCategory) {
        state = state.copyWith(
          createTransactionCategoryResult: Resource.success(createdCategory),
        );
        getTransactionCategories();
        resetCategoryForm();
      },
      failure: (error) {
        state = state.copyWith(
          createTransactionCategoryResult: Resource.failure(error),
        );
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
      },
      failure: (_) {},
    );
  }
  
  void updateCategoryName(String value) {
    state = state.copyWith(newCategoryName: value);
  }
  
  bool isCategoryNameValid() {
    return state.newCategoryName.isNotEmpty;
  }
  
  void resetCategoryForm() {
    state = state.copyWith(
      newCategoryName: '',
      createTransactionCategoryResult: const Resource.initial(),
    );
  }
}
