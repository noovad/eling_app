import 'package:eling_app/core/enum/todo_sheet_type.dart';
import 'package:eling_app/core/enum/todo_tabs_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_form.dart';

enum TaskType { daily, productivity }

class TodoSheet extends StatefulWidget {
  final FormMode? type;
  final TodoTabsType? todoTabsType;
  final TaskType? taskType;

  const TodoSheet.create({
    super.key,
    required this.todoTabsType,
    required this.taskType,
  }) : type = FormMode.create;

  const TodoSheet.update({
    super.key,
    required this.todoTabsType,
    required this.taskType,
  }) : type = FormMode.update;

  const TodoSheet.detail({super.key, required this.todoTabsType})
    : type = FormMode.detail,
      taskType = null;

  @override
  State<TodoSheet> createState() => _TodoSheetState();
}

class _TodoSheetState extends State<TodoSheet> {
  bool get isCreate => widget.type == FormMode.create;
  bool get isUpdate => widget.type == FormMode.update;
  @override
  void dispose() {
    super.dispose();
  }

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
              child: TodoForm(
                todoTabsType: widget.todoTabsType!,
                taskType: widget.taskType,
              ),
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
