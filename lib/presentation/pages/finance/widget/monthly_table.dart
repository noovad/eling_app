import 'package:eling_app/presentation/pages/finance/widget/transaction_type_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';

class MonthlyTable extends StatelessWidget {
  const MonthlyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SizedBox(width: 300, child: TransactionTypeDropdown()),
            ),
            AppDateNav(),
          ],
        ),
        Expanded(
          child: DataTable(
            dividerThickness: 0.2,
            showCheckboxColumn: false,
            columns: const [
              DataColumn(
                columnWidth: FlexColumnWidth(2),
                label: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 4),
                    Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              DataColumn(
                columnWidth: FlexColumnWidth(4),
                label: Row(
                  children: [
                    Icon(Icons.title, size: 16),
                    SizedBox(width: 4),
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
                    SizedBox(width: 4),
                    Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                columnWidth: FlexColumnWidth(2),
                label: Row(
                  children: [
                    Icon(Icons.attach_money, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Ammount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('01/01/2023')),
                  DataCell(Text('Sample Task 1')),
                  DataCell(Text('Work')),
                  DataCell(Text('2 hours')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('02/01/2023')),
                  DataCell(Text('Sample Task 2')),
                  DataCell(Text('Personal')),
                  DataCell(Text('1 hour')),
                ],
              ),
              // Add more rows as needed
            ],
          ),
        ),
      ],
    );
  }
}
