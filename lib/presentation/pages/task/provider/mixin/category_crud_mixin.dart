part of '../task_notifier.dart';

mixin CategoryCRUDMixin on StateNotifier<TaskState> {
  GetCategoriesUseCase get getCategoriesUseCase;

  void saveCategory() async {
    final categoryTitle = state.categoryTitle.value;
    debugPrint('Saving category with title: $categoryTitle');
  }

  void deleteCategory(String name) async {
    debugPrint('Deleting category $name');
  }

  void getCategories(CategoryType categoryType) async {
    final result = await getCategoriesUseCase.execute(
      GetCategoriesRequest(categoryType: categoryType),
    );
    result.when(
      success: (data) {
        switch (categoryType) {
          case CategoryType.daily:
            state = state.copyWith(dailyCategories: Resource.success(data));
          case CategoryType.productivity:
            state = state.copyWith(
              productivityCategories: Resource.success(data),
            );
          case CategoryType.note:
            state = state.copyWith(noteCategories: Resource.success(data));
        }
      },
      failure: (error) {
        switch (categoryType) {
          case CategoryType.daily:
            state = state.copyWith(dailyCategories: Resource.failure(error));
          case CategoryType.productivity:
            state = state.copyWith(
              productivityCategories: Resource.failure(error),
            );
          case CategoryType.note:
            state = state.copyWith(noteCategories: Resource.failure(error));
        }
      },
    );
  }
}
