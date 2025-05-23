import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:flutter/material.dart';
import 'package:eling_app/presentation/pages/task/widget/task_list_data.dart';

class TaskSection extends StatelessWidget {
  final TaskTabsType tabsType;
  const TaskSection({super.key, required this.tabsType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskListData(tabsType: tabsType, taskType: TaskType.productivity),
        TaskListData(tabsType: tabsType, taskType: TaskType.daily),
      ],
    );
  }
}
