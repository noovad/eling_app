import 'package:eling_app/core/enum/category_type.dart';
import 'package:eling_app/presentation/enum/task_schedule_type.dart';
import 'package:eling_app/core/providers/notifier/task_notifier_provider.dart';
import 'package:eling_app/presentation/pages/todoPage/task/notifier/task_notifier.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/category_sheet.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/task_section.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/task_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/widgets/appPopOver/app_pop_over.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskNotifierProvider.notifier);

    return Padding(
      padding: AppPadding.all12,
      child: AppTabs(
        length: 4,
        tabBar: const [
          Tab(text: 'Today'),
          Tab(text: 'Upcoming'),
          Tab(text: 'Recurring'),
          Tab(text: 'Completed'),
        ],
        tabBarView: [
          TaskSection(taskScheduleType: TaskScheduleType.today),
          TaskSection(taskScheduleType: TaskScheduleType.upcoming),
          TaskSection(taskScheduleType: TaskScheduleType.recurring),
          TablePage(),
        ],
        tabBarChild: SizedBox(
          height: AppSizes.dimen60,
          child: AppPopOver(
            padding: AppPadding.all12,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSizes.dimen12,
              children: [
                categoryButton(
                  context,
                  CategoryType.daily,
                  "Daily Category",
                  notifier,
                ),
                categoryButton(
                  context,
                  CategoryType.productivity,
                  "Productivity Category",
                  notifier,
                ),
                categoryButton(
                  context,
                  CategoryType.note,
                  "Note Category",
                  notifier,
                ),
              ],
            ),
            trigger: Material(
              color: Colors.black,
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: AppSizes.dimen60,
                child: Icon(Icons.more_horiz, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton categoryButton(
    BuildContext context,
    CategoryType categoryType,
    String title,
    TaskNotifier notifier,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        alignment: Alignment.centerLeft,
      ),
      onPressed: () {
        notifier.resetCategoryForm();
        appSheet(
          context: context,
          side: SheetSide.left,
          builder: (context) => CategorySheet(categoryType: categoryType),
        );
      },
      child: Align(alignment: Alignment.centerLeft, child: Text(title)),
    );
  }
}
