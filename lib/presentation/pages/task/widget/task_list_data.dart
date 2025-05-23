import 'package:eling_app/core/utils/resource.dart';
import 'package:eling_app/domain/entities/taskGroupResult/task_group_result.dart';
import 'package:eling_app/presentation/enum/task_type.dart';
import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/pages/task/provider/task_provider.dart';
import 'package:eling_app/presentation/pages/task/widget/task_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appCard/task_card.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListData extends ConsumerWidget {
  final TaskTabsType tabsType;
  final TaskType taskType;

  const TaskListData({
    super.key,
    required this.tabsType,
    required this.taskType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final Resource<TaskGroupResultEntity> tasks;
    switch (tabsType) {
      case TaskTabsType.upcoming:
        tasks = ref.watch(taskProvider.select((s) => s.upcomingTask));
        break;
      case TaskTabsType.recurring:
        tasks = ref.watch(taskProvider.select((s) => s.recurringTask));
        break;
      case TaskTabsType.today:
      default:
        tasks = ref.watch(taskProvider.select((s) => s.todayTask));
        break;
    }

    return Expanded(
      child: Column(
        spacing: 12,
        children: [
          Padding(
            padding: AppPadding.h12,
            child: appCard(
              height: 50,
              child: InkWell(
                onTap:
                    () => appSheet(
                      side: SheetSide.right,
                      context: context,
                      builder:
                          (context) => TaskSheet.create(
                            taskType: taskType,
                            todoTabsType: TaskTabsType.today,
                          ),
                    ),
                child: const Padding(
                  padding: AppPadding.h8,
                  child: Icon(Icons.add, size: 24),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 172,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: tasks.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (message) {
                return Text(message);
              },
              success:
                  (data) => ListView.builder(
                    padding: AppPadding.h12,
                    itemCount: data.tasksByType[taskType]?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final task = data.tasksByType[taskType]![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TaskCard(
                          title: task.title ?? "",
                          category: task.category ?? "",
                          time: task.time ?? "",
                          isDone: task.isDone ?? false,
                          id: task.id ?? "",
                          onUpdateStatus: (fd) {},
                          onDelete: (fd) {},
                          leading: true,
                          ontap:
                              () => appSheet(
                                context: context,
                                side: SheetSide.right,
                                builder:
                                    (context) => TaskSheet.update(
                                      todoTabsType: TaskTabsType.today,
                                      taskType: TaskType.daily,
                                    ),
                              ),
                        ),
                      );
                    },
                  ),
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
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: child,
      ),
    );
  }
}
