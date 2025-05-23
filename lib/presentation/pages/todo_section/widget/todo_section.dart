import 'package:eling_app/presentation/enum/todo_tabs_type.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:flutter/material.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_list_data.dart';

class TodoSection extends StatelessWidget {
  final TodoTabsType tabsType;
  const TodoSection({super.key, required this.tabsType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [TodoListData(
        tabsType: tabsType,
        taskType: TaskType.productivity
      ), TodoListData(
        tabsType: tabsType,
        taskType: TaskType.daily
      )],
    );
  }
}
