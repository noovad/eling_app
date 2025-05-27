part of '../task_notifier.dart';

mixin TaskFormMixin on StateNotifier<TaskState> {
  void titleChanged(String value) {
    final title = TitleInput.dirty(value: value);
    final isValid = Formz.validate([title, state.date]);
    state = state.copyWith(title: title, isValid: isValid);
  }

  void dateChanged(String value) {
    final date = DateInput.dirty(value: value);
    final isValid = Formz.validate([state.title, date]);
    state = state.copyWith(date: date, isValid: isValid);
  }

  void categoryChanged(String value) {
    state = state.copyWith(selectedCategory: value);
  }

  void timeChanged(String value) {
    state = state.copyWith(time: value);
  }

  void noteChanged(String value) {
    state = state.copyWith(note: value);
  }

  void setUpdateForm(TaskEntity task, TaskScheduleType? tabsType) {
    final isRecurring = tabsType == TaskScheduleType.recurring;
    final dateValue =
        isRecurring ? DateTime.now().toString() : task.date.toString();
    state = state.copyWith(
      title: TitleInput.dirty(value: task.title),
      date: DateInput.dirty(value: dateValue),
      isValid: true,
      selectedCategory: task.category,
      note: task.note,
      time: task.time,
    );
  }

  void resetForm(TaskScheduleType tabsType) {
    final isRecurring = tabsType == TaskScheduleType.recurring;
    state = state.copyWith(
      title: TitleInput.pure(),
      date:
          isRecurring
              ? DateInput.dirty(value: DateTime.now().toString())
              : DateInput.pure(),
      isValid: false,
      selectedCategory: null,
      note: null,
      time: null,
    );
  }

  void resetIsSaving() {
    state = state.copyWith(saveResult: Resource.initial());
  }

  void resetIsUpdate() {
    state = state.copyWith(updateResult: Resource.initial());
  }
}
