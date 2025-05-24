import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/pages/task/widget/task_section.dart';
import 'package:eling_app/presentation/pages/task/widget/task_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/app_tabs.dart/app_tabs.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            TaskSection(tabsType: TaskTabsType.today),
            TaskSection(tabsType: TaskTabsType.upcoming),
            TaskSection(tabsType: TaskTabsType.recurring),
            TablePage(),
          ],
          tabBarChild: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.more_horiz),
            ),
          ),
        ),
      ),
    );
  }
}
