import 'package:eling/core/utils/constants/date_constants.dart';
import 'package:eling/core/utils/resource.dart';
import 'package:eling/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling/presentation/enum/task_type.dart';
import 'package:eling/presentation/enum/task_schedule_type.dart';
import 'package:eling/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling/presentation/pages/todoPage/task/widget/task_sheet.dart';
import 'package:eling/presentation/utils/task_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appCard/app_task_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appUtils/app_no_data_found.dart';

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
    final notifier = ref.read(taskNotifierProvider.notifier);
    late final Resource<TaskGroupResultEntity> tasks;
    switch (taskScheduleType) {
      case TaskScheduleType.upcoming:
        tasks = ref.watch(taskNotifierProvider.select((s) => s.upcomingTask));
        break;
      case TaskScheduleType.recurring:
        tasks = TaskConverters.convertRecurringToTaskGroupResource(
          ref.watch(taskNotifierProvider.select((s) => s.recurringTask)),
        );
        break;
      case TaskScheduleType.today:
        tasks = ref.watch(taskNotifierProvider.select((s) => s.todayTask));
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
              child: Padding(
                padding: AppPadding.h8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 24),
                    AppSpaces.w4,
                    Text(
                      taskType == TaskType.daily
                          ? 'Daily Task'
                          : 'Productivity Task',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 172,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: tasks.whenOrNull(
              failure: (error) {
                return Center(child: Text(error));
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
                    bool isOverDue =
                        task.date.isBefore(DateTime.now()) &&
                        !DateConstants.isToday(task.date);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppTaskCard(
                        title: task.title,
                        category: task.category ?? "",
                        time: task.time ?? "",
                        isDone: task.isDone ?? false,
                        id: task.id,
                        isOverDue: isOverDue,
                        date:
                            TaskScheduleType.upcoming == taskScheduleType
                                ? DateConstants.formatToShortDate(task.date)
                                : null,
                        onUpdateStatus:
                            () => notifier.updateStatus(
                              task.id,
                              task.isDone ?? false,
                              taskScheduleType,
                            ),
                        onDelete: () {
                          if (taskScheduleType == TaskScheduleType.recurring) {
                            notifier.deleteRecurringTask(task.id);
                          } else {
                            notifier.deleteTask(task.id);
                          }
                        },
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
                                  task: task,
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

  Widget appCard({required Widget child, Color? color, double? height}) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Card(color: color, child: child),
    );
  }
}
