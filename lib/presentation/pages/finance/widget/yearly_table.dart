import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appNav/app_year_nav.dart';

class YearlyTable extends StatelessWidget {
  const YearlyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        AppYearNav(),
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
                    Text(
                      'Month',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                columnWidth: FlexColumnWidth(2),

                label: Row(
                  children: [
                    Icon(Icons.trending_up, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Income',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                columnWidth: FlexColumnWidth(2),

                label: Row(
                  children: [
                    Icon(Icons.trending_down, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Expenses',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              DataColumn(
                columnWidth: FlexColumnWidth(2),

                label: Row(
                  children: [
                    Icon(Icons.move_to_inbox, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Savings',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('January')),
                  DataCell(Text('5,000,000')),
                  DataCell(Text('3,000,000')),
                  DataCell(Text('2,000,000')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('February')),
                  DataCell(Text('5,200,000')),
                  DataCell(Text('2,800,000')),
                  DataCell(Text('2,400,000')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('March')),
                  DataCell(Text('5,100,000')),
                  DataCell(Text('3,100,000')),
                  DataCell(Text('2,000,000')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('April')),
                  DataCell(Text('5,300,000')),
                  DataCell(Text('3,500,000')),
                  DataCell(Text('1,800,000')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('May')),
                  DataCell(Text('5,400,000')),
                  DataCell(Text('3,200,000')),
                  DataCell(Text('2,200,000')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('June')),
                  DataCell(Text('5,000,000')),
                  DataCell(Text('3,300,000')),
                  DataCell(Text('1,700,000')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(
                    Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                      '31,000,000',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                      '18,900,000',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                      '12,100,000',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
