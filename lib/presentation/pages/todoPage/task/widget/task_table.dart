import 'package:eling_app/core/providers/notifier/task_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:flutter_ui/widgets/utils/app_no_data_found.dart';
import 'package:intl/intl.dart';
import 'package:eling_app/presentation/pages/todoPage/task/widget/task_sheet.dart';

class TablePage extends ConsumerWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskNotifierProvider.notifier);
    final completedTasks = ref.watch(
      taskNotifierProvider.select((s) => s.completedTasks),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height - 104,
      width: double.infinity,
      child: Column(
        spacing: 16,
        children: [
          AppDateNav(
            onChange: (date) {
              notifier.getCompletedTasks(date.month, date.year);
            },
          ),
          Flexible(
            child: SingleChildScrollView(
              child: DataTable(
                dividerThickness: 0.2,
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(
                    columnWidth: FlexColumnWidth(2),
                    label: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    columnWidth: FlexColumnWidth(4),
                    label: Text(
                      'Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    columnWidth: FlexColumnWidth(2),
                    label: Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    columnWidth: FlexColumnWidth(2),
                    label: Text(
                      'Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: completedTasks.when(
                  initial: () => [],
                  loading: () => [],
                  failure: (e) => [],
                  success:
                      (data) =>
                          data
                              .map(
                                (todo) => DataRow(
                                  onSelectChanged: (selected) {
                                    notifier.setUpdateForm(todo, null);
                                    appSheet(
                                      context: context,
                                      side: SheetSide.right,
                                      builder: (context) => TaskSheet.detail(),
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
          completedTasks.when(
            initial:
                () => Expanded(
                  child: const Center(child: CircularProgressIndicator()),
                ),
            loading:
                () => Expanded(
                  child: const Center(child: CircularProgressIndicator()),
                ),
            failure: (message) {
              return Expanded(child: Text(message));
            },
            success: (value) {
              if (value.isEmpty) {
                return Expanded(child: AppNoDataFound());
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
