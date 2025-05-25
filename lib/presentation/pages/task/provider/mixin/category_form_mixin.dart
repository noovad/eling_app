part of '../task_notifier.dart';

mixin CategoryFormMixin on StateNotifier<TaskState> {
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
