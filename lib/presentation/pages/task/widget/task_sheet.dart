import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/form_mode.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/pages/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/presentation/pages/task/widget/task_form.dart';

class TaskSheet extends ConsumerWidget {
  final FormMode? type;
  final TaskTabsType tabsType;
  final TaskType? taskType;
  final bool? isDone;

  const TaskSheet.create({
    super.key,
    required this.tabsType,
    required this.taskType,
  }) : type = FormMode.create,
       isDone = false;

  const TaskSheet.update({
    super.key,
    required this.tabsType,
    required this.taskType,
    required this.isDone,
  }) : type = FormMode.update;

  const TaskSheet.detail({super.key, required this.tabsType})
    : type = FormMode.detail,
      isDone = false,
      taskType = null;

  bool get isCreate => type == FormMode.create;
  bool get isUpdate => type == FormMode.update;
  bool get idDetail => type == FormMode.detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskProvider.notifier);
    final isValid = ref.watch(taskProvider.select((state) => state.isvalid));

    bool enabled = (isDone == true) || (idDetail) ? false : true;

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: TaskForm(
                tabsType: tabsType,
                taskType: taskType,
                enabled: enabled,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                if (enabled)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      AppSpaces.w8,
                      ElevatedButton(
                        onPressed:
                            isValid == true
                                ? () =>
                                    isCreate
                                        ? notifier.saveTask()
                                        : notifier.updateTask()
                                : null,
                        child: Text(isCreate ? 'Create' : 'Update'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
