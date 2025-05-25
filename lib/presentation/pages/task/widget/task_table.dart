import 'package:eling_app/presentation/enum/task_tabs_type.dart';
import 'package:eling_app/presentation/pages/task/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appNav/app_month_nav.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:intl/intl.dart';
import 'package:eling_app/presentation/pages/task/widget/task_sheet.dart';

class TablePage extends ConsumerWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskProvider.notifier);
    final completedTasks = ref.watch(
      taskProvider.select((s) => s.completedTasks),
    );
    final listData = completedTasks.whenOrNull(success: (date) => date) ?? [];
    return SizedBox(
      height: MediaQuery.of(context).size.height - 104,
      child: Column(
        spacing: 16,
        children: [
          AppMonthNav(displayedDate: ValueNotifier<DateTime>(DateTime.now())),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: DataTable(
                    dividerThickness: 0.2,
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Title',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Time',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows:
                        listData
                            .map(
                              (todo) => DataRow(
                                onSelectChanged: (selected) {
                                  notifier.setUpdateForm(
                                    todo,
                                    TaskTabsType.completed,
                                  );
                                  appSheet(
                                    context: context,
                                    side: SheetSide.right,
                                    builder:
                                        (context) => TaskSheet.detail(
                                          tabsType: TaskTabsType.completed,
                                        ),
                                  );
                                },
                                cells: [
                                  DataCell(
                                    Text(
                                      DateFormat(
                                        'dd MMM yyyy',
                                      ).format(todo.date),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      todo.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      todo.category ?? '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      (todo.time ?? ''),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
