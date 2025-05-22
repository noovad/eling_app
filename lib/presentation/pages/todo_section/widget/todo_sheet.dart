import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_form.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_section.dart';

enum TodoSheetType { create, update, detail }

enum TaskType { daily, productivity }

class TodoSheet extends StatefulWidget {
  final TodoSheetType? type;
  final TabsType? tabsType;
  final TaskType? taskType;

  const TodoSheet.create({
    super.key,
    required this.tabsType,
    required this.taskType,
  }) : type = TodoSheetType.create;

  const TodoSheet.update({
    super.key,
    required this.tabsType,
    required this.taskType,
  }) : type = TodoSheetType.update;

  const TodoSheet.detail({super.key, required this.tabsType})
    : type = TodoSheetType.detail,
      taskType = null;

  @override
  State<TodoSheet> createState() => _TodoSheetState();
}

class _TodoSheetState extends State<TodoSheet> {
  bool get isCreate => widget.type == TodoSheetType.create;
  bool get isUpdate => widget.type == TodoSheetType.update;
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
                tabsType: widget.tabsType!,
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
