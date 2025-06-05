import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appNav/app_year_nav.dart';
import 'package:intl/intl.dart';

class YearlyTable extends ConsumerWidget {
  const YearlyTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final yearlyTransactions = ref.watch(
      financeNotifierProvider.select((state) => state.yearlyTransactions),
    );

    final currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Column(
      children: [
        AppSpaces.h24,
        AppYearNav(
          onChange: (date) {
            notifier.updateFilter(date: date);
          },
        ),
        AppSpaces.h24,
        Expanded(
          child: yearlyTransactions.when(
            initial:
                () => const Center(child: Text('Select a year to view data')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (monthlyData) {
              final monthlySummaries = _calculateMonthlySummaries(monthlyData);

              double totalIncome = 0;
              double totalExpense = 0;
              double totalSavings = 0;

              monthlySummaries.forEach((month, data) {
                totalIncome += data['income'] ?? 0;
                totalExpense += data['expense'] ?? 0;
                totalSavings += data['savings'] ?? 0;
              });

              return DataTable(
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
                rows: [
                  for (int month = 1; month <= 12; month++)
                    _buildMonthRow(
                      month,
                      monthlySummaries[month] ??
                          {'income': 0.0, 'expense': 0.0, 'savings': 0.0},
                      currencyFormatter,
                    ),

                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(
                        Text(
                          currencyFormatter.format(totalIncome),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          currencyFormatter.format(totalExpense),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          currencyFormatter.format(totalSavings),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            failure:
                (error) => Center(child: Text('Error: ${error.toString()}')),
          ),
        ),
      ],
    );
  }

  DataRow _buildMonthRow(
    int month,
    Map<String, double> data,
    NumberFormat formatter,
  ) {
    final monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return DataRow(
      cells: [
        DataCell(Text(monthNames[month])),
        DataCell(
          Text(
            formatter.format(data['income'] ?? 0),
            style: TextStyle(color: Colors.green),
          ),
        ),
        DataCell(
          Text(
            formatter.format(data['expense'] ?? 0),
            style: TextStyle(color: Colors.red),
          ),
        ),
        DataCell(
          Text(
            formatter.format(data['savings'] ?? 0),
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  Map<int, Map<String, double>> _calculateMonthlySummaries(
    Map<int, List<TransactionEntity>> monthlyData,
  ) {
    final Map<int, Map<String, double>> monthlySummaries = {};

    monthlyData.forEach((month, transactions) {
      double income = 0;
      double expense = 0;
      double savings = 0;

      for (final transaction in transactions) {
        switch (transaction.type) {
          case TransactionType.income:
            income += transaction.amount;
            break;
          case TransactionType.expense:
            expense += transaction.amount;
            break;
          case TransactionType.savings:
            savings += transaction.amount;
            break;
          case TransactionType.transfer:
            break;
        }
      }

      monthlySummaries[month] = {
        'income': income,
        'expense': expense,
        'savings': savings,
      };
    });

    return monthlySummaries;
  }
}
