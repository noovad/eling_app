import 'package:eling_app/presentation/pages/finance/widget/transaction_type_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDialog/app_dialog.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';

class MonthlyTable extends StatelessWidget {
  const MonthlyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.h24,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: TransactionTypeDropdown(),
              ),
            ),
            Expanded(child: AppDateNav()),
          ],
        ),
        AppSpaces.h24,
        Expanded(
          child: DataTable(
            dividerThickness: 0.2,
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                label: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    AppSpaces.w4,
                    Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Icon(Icons.title, size: 16),
                    AppSpaces.w4,
                    Text(
                      'Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                columnWidth: FlexColumnWidth(2),
                label: Row(
                  children: [
                    Icon(Icons.topic, size: 16),
                    AppSpaces.w4,
                    Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Icon(Icons.attach_money, size: 16),
                    AppSpaces.w4,
                    Text(
                      'Ammount',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.more_vert, size: 16),
                      AppSpaces.w4,
                      Text(
                        'Action',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text('01 Nov 2023')),
                  DataCell(
                    Text('Sample Task 1 dddddddddddddddddddddddddddddddddddd'),
                  ),
                  DataCell(Text('Work dddddddddddddddddddddd')),
                  DataCell(Text('2 hours')),
                  DataCell(
                    Center(
                      child: AppDialog(
                        trigger: Icon(Icons.delete_outline),
                        content: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Are you sure you want to delete this data?',
                                  ),
                                ),
                              ),
                              AppSpaces.h16,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    child: Text('Cancel'),
                                  ),
                                  AppSpaces.w8,
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
