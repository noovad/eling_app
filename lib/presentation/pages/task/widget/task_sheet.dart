import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/form_mode.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/presentation/pages/task/widget/task_form.dart';

class TaskSheet extends StatelessWidget {
  final FormMode? type;
  final TaskTabsType todoTabsType;
  final TaskType? taskType;

  const TaskSheet.create({
    super.key,
    required this.todoTabsType,
    required this.taskType,
  }) : type = FormMode.create;

  const TaskSheet.update({
    super.key,
    required this.todoTabsType,
    required this.taskType,
  }) : type = FormMode.update;

  const TaskSheet.detail({super.key, required this.todoTabsType})
    : type = FormMode.detail,
      taskType = null;

  bool get isCreate => type == FormMode.create;

  bool get isUpdate => type == FormMode.update;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: TaskForm(todoTabsType: todoTabsType, taskType: taskType),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: buttonSection(context),
          ),
        ],
      ),
    );
  }

  Row buttonSection(BuildContext context) {
    return Row(
      children: [
        if (isCreate || (isUpdate && true))
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(
                onPressed: () {},
                child: Text(isCreate ? 'Create' : 'Update'),
              ),
            ],
          ),
      ],
    );
  }
}
