import 'package:eling/presentation/enum/task_type.dart';
import 'package:eling/presentation/enum/task_schedule_type.dart';
import 'package:eling/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';
import 'package:flutter_ui/widgets/appField/app_date_field.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:flutter_ui/widgets/appField/app_time_field.dart';

class TaskForm extends ConsumerWidget {
  final TaskScheduleType? taskScheduleType;
  final TaskType? taskType;
  final bool enabled;

  const TaskForm({
    super.key,
    required this.enabled,
    this.taskScheduleType,
    this.taskType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(
      taskNotifierProvider.select((state) => state.selectedCategory),
    );
    final title = ref.watch(
      taskNotifierProvider.select((state) => state.title),
    );
    final time = ref.watch(taskNotifierProvider.select((state) => state.time));
    final date = ref.watch(taskNotifierProvider.select((state) => state.date));
    final note = ref.watch(taskNotifierProvider.select((state) => state.note));
    final notifier = ref.read(taskNotifierProvider.notifier);

    final dataCategories =
        taskType == TaskType.daily
            ? ref.watch(
              taskNotifierProvider.select((state) => state.dailyCategories),
            )
            : ref.watch(
              taskNotifierProvider.select(
                (state) => state.productivityCategories,
              ),
            );

    final categories = dataCategories.whenOrNull(
      success:
          (data) =>
              data
                  .map((e) => DropdownItem<String>(id: e.name, label: e.name))
                  .toList(),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: "Title",
          hint: "Enter title",
          onChanged: notifier.titleChanged,
          errorText: title.displayError?.message,
          initialValue: title.value,
          enabled: enabled,
          isRequired: true,
          maxLines: 1,
        ),
        AppSpaces.h24,
        AppDropdown(
          items: [
            if (taskType == TaskType.daily) ...[
              DropdownItem<String>(id: 'Sholat Fardhu', label: 'Sholat Fardhu'),
              DropdownItem<String>(id: 'Gym', label: 'Gym'),
              DropdownItem<String>(id: 'Cardio', label: 'Cardio'),
              DropdownItem<String>(
                id: 'Calorie Controlled',
                label: 'Calorie Controlled',
              ),
            ],
            if (taskType == TaskType.productivity)
              DropdownItem<String>(id: 'Coding', label: 'Coding'),
            ...?categories,
          ],
          label: "Category",
          hint: "Select category",
          enabled: enabled,
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
          onChanged: notifier.timeChanged,
          initialValue: time,
          enabled: enabled,
        ),
        AppSpaces.h24,
        Visibility(
          visible: taskScheduleType != TaskScheduleType.recurring,
          child: Column(
            children: [
              AppDateField(
                onChanged: (value) => notifier.dateChanged(value.toString()),
                initialValue: date.isValid ? DateTime.parse(date.value) : null,
                errorText: date.displayError?.message,
                enabled: enabled,
                isRequired: true,
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
          onChanged: notifier.noteChanged,
          initialValue: note,
          enabled: enabled,
        ),
      ],
    );
  }
}
