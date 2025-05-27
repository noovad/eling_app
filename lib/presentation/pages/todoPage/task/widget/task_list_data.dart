// ignore_for_file: deprecated_member_use

import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/task_schedule_type.dart';
import 'package:eling_app/presentation/pages/todoPage/task/provider/task_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/task_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appCard/app_task_card.dart';
import 'package:flutter_ui/widgets/appCard/app_task_shimmer_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/utils/app_no_data_found.dart';

class TaskListData extends ConsumerWidget {
  final TaskScheduleType taskScheduleType;
  final TaskType taskType;

  const TaskListData({
    super.key,
    required this.taskScheduleType,
    required this.taskType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskProvider.notifier);
    late final Resource<TaskGroupResultEntity> tasks;
    switch (taskScheduleType) {
      case TaskScheduleType.upcoming:
        tasks = ref.watch(taskProvider.select((s) => s.upcomingTask));
        break;
      case TaskScheduleType.recurring:
        tasks = ref.watch(taskProvider.select((s) => s.recurringTask));
        break;
      case TaskScheduleType.today:
        tasks = ref.watch(taskProvider.select((s) => s.todayTask));
        break;
    }

    return Expanded(
      child: Column(
        spacing: 12,
        children: [
          appCard(
            height: 50,
            child: InkWell(
              onTap: () {
                notifier.resetForm(taskScheduleType);
                appSheet(
                  side: SheetSide.right,
                  context: context,
                  builder:
                      (context) => TaskSheet.create(
                        taskType: taskType,
                        taskScheduleType: taskScheduleType,
                      ),
                );
              },
              child: const Padding(
                padding: AppPadding.h8,
                child: Icon(Icons.add, size: 24),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 172,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: tasks.when(
              initial: () => _buildShimmerList(),
              loading: () => _buildShimmerList(),
              failure: (message) {
                return Text(message);
              },
              success: (data) {
                if (data.tasksByType[taskType]!.isEmpty) {
                  return AppNoDataFound();
                }
                return ListView.builder(
                  itemCount: data.tasksByType[taskType]?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final task = data.tasksByType[taskType]![index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppTaskCard(
                        title: task.title,
                        category: task.category ?? "",
                        time: task.time ?? "",
                        isDone: task.isDone ?? false,
                        id: task.id!,
                        date:
                            TaskScheduleType.upcoming == taskScheduleType
                                ? "${task.date.day.toString().padLeft(2, '0')} ${task.date.month.toString().padLeft(2, '0')} ${task.date.year}"
                                : null,
                        onUpdateStatus:
                            () => notifier.updateStatus(
                              task.id!,
                              task.isDone!,
                              taskScheduleType,
                            ),
                        onDelete: () => notifier.deleteTask(task.id!),
                        leading: taskScheduleType != TaskScheduleType.recurring,
                        ontap: () {
                          notifier.setUpdateForm(task, taskScheduleType);
                          appSheet(
                            context: context,
                            side: SheetSide.right,
                            builder:
                                (context) => TaskSheet.update(
                                  taskScheduleType: taskScheduleType,
                                  taskType: taskType,
                                  isDone: task.isDone,
                                  taskId: task.id,
                                ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AppTaskShimmerCard(
            withLeading: taskScheduleType != TaskScheduleType.recurring,
          ),
        );
      },
    );
  }

  Widget appCard({required Widget child, Color? color, double? height}) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.withOpacity(0.25), width: 1),
        ),
        child: child,
      ),
    );
  }
}
