import 'package:eling_app/presentation/enum/task_schedule_type.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:flutter/material.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/task_list_data.dart';

class TaskSection extends StatelessWidget {
  final TaskScheduleType taskScheduleType;
  const TaskSection({super.key, required this.taskScheduleType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskListData(taskScheduleType: taskScheduleType, taskType: TaskType.productivity),
        TaskListData(taskScheduleType: taskScheduleType, taskType: TaskType.daily),
      ],
    );
  }
}
