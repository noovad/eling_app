import 'package:eling_app/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling_app/domain/entities/task/task.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/form_mode.dart';
import 'package:eling_app/presentation/enum/task_schedule_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/task_form.dart';

class TaskSheet extends ConsumerWidget {
  final TaskEntity? task;
  final FormMode? type;
  final TaskScheduleType? taskScheduleType;
  final TaskType? taskType;
  final bool? isDone;

  const TaskSheet.create({
    super.key,
    required this.taskScheduleType,
    required this.taskType,
  }) : type = FormMode.create,
       task = null,
       isDone = false;

  const TaskSheet.update({
    super.key,
    required this.task,
    required this.taskScheduleType,
    required this.taskType,
    required this.isDone,
  }) : type = FormMode.update;

  const TaskSheet.detail({super.key})
    : type = FormMode.detail,
      taskScheduleType = null,
      isDone = false,
      task = null,
      taskType = null;

  bool get isCreate => type == FormMode.create;
  bool get isUpdate => type == FormMode.update;
  bool get idDetail => type == FormMode.detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskNotifierProvider.notifier);
    final isValid = ref.watch(
      taskNotifierProvider.select((state) => state.isValid),
    );

    bool enabled = (isDone == true) || (idDetail) ? false : true;
    bool isRecurring = taskScheduleType == TaskScheduleType.recurring;

    VoidCallback? isButtonValid;
    if (isValid) {
      if (isCreate) {
        isButtonValid = () {
          isRecurring
              ? notifier.onSaveRT(taskType!)
              : notifier.saveTask(taskType!);
        };
      } else {
        isButtonValid = () {
          isRecurring ? notifier.onUpdateRT(task!) : notifier.updateTask(task!);
        };
      }
    } else {
      isButtonValid = null;
    }

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: TaskForm(
                taskScheduleType: taskScheduleType,
                taskType: taskType,
                enabled: enabled,
              ),
            ),
          ),
          AppSpaces.h16,
          Row(
            children: [
              Visibility(
                visible: enabled,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    AppSpaces.w8,
                    ElevatedButton(
                      onPressed: isButtonValid,
                      child: Text(isCreate ? 'Create' : 'Update'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
