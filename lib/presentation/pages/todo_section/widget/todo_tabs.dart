import 'package:eling_app/presentation/enum/todo_tabs_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_section.dart';
import 'package:eling_app/presentation/pages/todo_section/widget/todo_table.dart';

class TodoTabs extends StatelessWidget {
  const TodoTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.all12,
        child: DefaultTabController(
          animationDuration: const Duration(milliseconds: 500),
          length: 4,
          child: Column(
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: TabBar(
                        dividerHeight: 0,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        padding: AppPadding.all8,
                        tabs: const [
                          Tab(text: 'Today'),
                          Tab(text: 'Upcoming'),
                          Tab(text: 'Recurring'),
                          Tab(text: 'Completed'),
                        ],
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 0,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),
              AppSpaces.h16,
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  children: [
                    TodoSection(tabsType: TodoTabsType.today),
                    TodoSection(tabsType: TodoTabsType.upcoming),
                    TodoSection(tabsType: TodoTabsType.recurring),
                    TablePage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
