import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/pages/task/provider/task_provider.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_date_field.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:flutter_ui/widgets/appField/app_time_field.dart';
import 'package:flutter_ui/widgets/dropdown/app_dropdown.dart';

class TaskForm extends ConsumerWidget {
  final TaskTabsType tabsType;
  final TaskType? taskType;
  final bool enabled;

  const TaskForm({
    super.key,
    required this.tabsType,
    required this.enabled,
    this.taskType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("TaskForm: ${taskType?.name} - ${tabsType.name}");
    final selectedCategory = ref.watch(
      taskProvider.select((state) => state.selectedCategory),
    );
    final title = ref.watch(taskProvider.select((state) => state.title));
    final time = ref.watch(taskProvider.select((state) => state.time));
    final date = ref.watch(taskProvider.select((state) => state.date));
    final note = ref.watch(taskProvider.select((state) => state.note));
    final notifier = ref.read(taskProvider.notifier);

    final dataCategories =
        taskType == TaskType.daily
            ? ref.watch(taskProvider.select((state) => state.dailyCategories))
            : ref.watch(
              taskProvider.select((state) => state.productivityCategories),
            );

    final categories = dataCategories.whenOrNull(
      success:
          (data) =>
              data
                  .map((e) => DropdownItem<String>(id: e.name!, label: e.name!))
                  .toList(),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: "Title",
          hint: "Enter title",
          onChanged: (value) => notifier.titleChanged(value),
          errorText: title.displayError?.message,
          initialValue: title.value,
          enabled: enabled,
        ),
        AppSpaces.h24,
        AppDropdown(
          items: categories ?? [],
          label: "Category",
          hint: "Select category",
          enable: enabled,
          selectedItem:
              selectedCategory != null
                  ? DropdownItem<String>(
                    id: selectedCategory,
                    label: selectedCategory,
                  )
                  : null,
          onChanged:
              (value) => notifier.categoryChanged(value?.id.toString() ?? ''),
        ),
        AppSpaces.h24,
        AppTimeField(
          onChanged: (value) => notifier.timeChanged(value),
          initialValue: time,
        ),
        AppSpaces.h24,
        Visibility(
          visible: tabsType != TaskTabsType.recurring,
          child: Column(
            children: [
              AppDateField(
                onChanged: (value) => notifier.dateChanged(value.toString()),
                initialValue: date.isValid ? DateTime.parse(date.value) : null,
                errorText: date.displayError?.message,
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        AppTextField(
          label: "Note",
          hint: "Enter note",
          maxLines: 5,
          minLines: 3,
          onChanged: (value) => notifier.noteChanged(value),
          initialValue: note,
          enabled: enabled,
        ),
      ],
    );
  }
}
