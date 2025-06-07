part of '../task_notifier.dart';

mixin CategoryMixin on StateNotifier<TaskState> {
  GetCategoriesUseCase get getCategoriesUseCase;
  CreateCategoryUseCase get createCategoryUseCase;
  DeleteCategoryUseCase get deleteCategoryUseCase;

  void saveCategory(CategoryType type) async {
    final data = CategoryEntity(
      id: const Uuid().v4(),
      name: state.categoryTitle.value,
      type: type.name,
    );

    final result = await createCategoryUseCase.execute(
      CreateCategoryRequest(category: data),
    );

    result.when(
      success: (_) {
        getCategories(type);
        // resetCategoryForm();
        state = state.copyWith(saveResult: Resource.success('category'));
      },
      failure: (_) {
        state = state.copyWith(saveResult: Resource.failure('category'));
      },
    );
  }

  void deleteCategory(String id, CategoryType type) async {
    final result = await deleteCategoryUseCase.execute(
      DeleteCategoryRequest(id: id),
    );

    result.when(
      success: (_) {
        getCategories(type);
        state = state.copyWith(deleteResult: Resource.success('category'));
      },
      failure: (_) {
        state = state.copyWith(deleteResult: Resource.failure('category'));
      },
    );
  }

  void getCategories(CategoryType categoryType) async {
    final result = await getCategoriesUseCase.execute(
      GetCategoriesRequest(categoryType: categoryType),
    );

    void updateState(Resource<List<CategoryEntity>> resource) {
      switch (categoryType) {
        case CategoryType.daily:
          state = state.copyWith(dailyCategories: resource);
          break;
        case CategoryType.productivity:
          state = state.copyWith(productivityCategories: resource);
          break;
        case CategoryType.note:
          state = state.copyWith(noteCategories: resource);
          break;
      }
    }

    result.when(
      success: (data) => updateState(Resource.success(data)),
      failure: (error) => updateState(Resource.failure(error)),
    );
  }

  void categoyrTitleChanged(String value) {
    final categoryTitle = CategoryTitle.dirty(value: value);
    final isValidCategory = Formz.validate([categoryTitle]);
    state = state.copyWith(
      categoryTitle: categoryTitle,
      isValidCategory: isValidCategory,
    );
  }

  void resetCategoryForm() {
    state = state.copyWith(
      categoryTitle: CategoryTitle.pure(),
      isValidCategory: false,
    );
  }
}
