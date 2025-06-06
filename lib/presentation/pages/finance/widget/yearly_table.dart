import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/presentation/utils/mappers/transaction_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appNav/app_year_nav.dart';

class YearlyTable extends ConsumerStatefulWidget {
  const YearlyTable({super.key});

  @override
  ConsumerState<YearlyTable> createState() => _YearlyTableState();
}

class _YearlyTableState extends ConsumerState<YearlyTable> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final yearlyTransactions = ref.watch(
      financeNotifierProvider.select((state) => state.yearlyTransactions),
    );

    return Column(
      children: [
        AppSpaces.h24,
        AppYearNav(
          onChange: (date) {
            notifier.updateYearFilter(date.year);
          },
        ),
        AppSpaces.h24,
        Flexible(
          child: SingleChildScrollView(
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
                DataColumn(
                  columnWidth: FlexColumnWidth(2),
                  label: Row(
                    children: [
                      Icon(Icons.output, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Net Balance',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
              rows: yearlyTransactions.when(
                initial: () => [],
                loading: () => [],
                failure: (error) => [],
                success: (monthlyData) {
                  final monthlySummaries = TransactionMapper.toMonthlySummaries(
                    monthlyData,
                  );
                  final totals = TransactionMapper.calculateTotals(
                    monthlySummaries,
                  );

                  List<DataRow> rows = [];

                  for (int month = 1; month <= 12; month++) {
                    rows.add(
                      _buildMonthRow(
                        month,
                        monthlySummaries[month] ??
                            {'income': 0.0, 'expense': 0.0, 'savings': 0.0},
                      ),
                    );
                  }

                  rows.add(
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
                            StringConstants.formatCurrency(
                              totals['income'] ?? 0,
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            StringConstants.formatCurrency(
                              totals['expense'] ?? 0,
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            StringConstants.formatCurrency(
                              totals['savings'] ?? 0,
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataCell(
                          Text(
                            StringConstants.formatCurrency(
                              totals['netBalance'] ?? 0,
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );

                  return rows;
                },
              ),
            ),
          ),
        ),
        yearlyTransactions.when(
          initial:
              () => Expanded(
                child: const Center(child: Text('Select a year to view data')),
              ),
          loading:
              () => Expanded(
                child: const Center(child: CircularProgressIndicator()),
              ),
          failure: (message) {
            return Expanded(child: Text(message.toString()));
          },
          success: (value) {
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  DataRow _buildMonthRow(int month, Map<String, double> data) {
    final monthNames = StringConstants.monthNames;
    final netBalance =
        (data['income'] ?? 0) - (data['expense'] ?? 0) + (data['savings'] ?? 0);

    return DataRow(
      cells: [
        DataCell(Text(monthNames[month])),
        DataCell(Text(StringConstants.formatCurrency(data['income'] ?? 0))),
        DataCell(Text(StringConstants.formatCurrency(data['expense'] ?? 0))),
        DataCell(Text(StringConstants.formatCurrency(data['savings'] ?? 0))),
        DataCell(
          Text(
            StringConstants.formatCurrency(netBalance),
            style: TextStyle(
              color: netBalance >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
