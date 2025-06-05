import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/presentation/pages/finance/widget/transaction_type_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDialog/app_dialog.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';
import 'package:intl/intl.dart';

class MonthlyTable extends ConsumerWidget {
  const MonthlyTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final transactions = ref.watch(
      financeNotifierProvider.select((state) => state.monthlyTransactions),
    );

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
                child: TransactionTypeDropdown(
                  onChanged: (type) {
                    notifier.updateFilter(type: type);
                  },
                ),
              ),
            ),
            Expanded(
              child: AppDateNav(
                onChange: (date) {
                  notifier.updateFilter(date: date);
                },
              ),
            ),
          ],
        ),
        AppSpaces.h24,
        Expanded(
          child: transactions.when(
            initial:
                () => const Center(
                  child: Text('Select a date to view transactions'),
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (data) {
              if (data.isEmpty) {
                return const Center(child: Text('No transactions found'));
              }

              return DataTable(
                dividerThickness: 0.2,
                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                    label: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16),
                        AppSpaces.w4,
                        Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                rows:
                    data.map((transaction) {
                      // Format the date
                      final formattedDate = DateFormat(
                        'dd MMM yyyy',
                      ).format(transaction.date);

                      // Format the amount with currency formatting
                      final amountFormat = NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      );
                      final formattedAmount = amountFormat.format(
                        transaction.amount,
                      );

                      // Set color based on transaction type
                      final Color amountColor = _getColorForTransactionType(
                        transaction.type,
                      );

                      return DataRow(
                        cells: [
                          DataCell(Text(formattedDate)),
                          DataCell(Text(transaction.title)),
                          DataCell(Text(transaction.category ?? '-')),
                          DataCell(
                            Text(
                              formattedAmount,
                              style: TextStyle(
                                color: amountColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: AppDialog(
                                trigger: const Icon(Icons.delete_outline),
                                content: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      const Expanded(
                                        child: Center(
                                          child: Text(
                                            'Are you sure you want to delete this transaction?',
                                          ),
                                        ),
                                      ),
                                      AppSpaces.h16,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed:
                                                () =>
                                                    Navigator.of(context).pop(),
                                            child: const Text('Cancel'),
                                          ),
                                          AppSpaces.w8,
                                          ElevatedButton(
                                            onPressed: () {
                                              notifier.deleteTransaction(
                                                transaction.id,
                                              );
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Delete'),
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
                      );
                    }).toList(),
              );
            },
            failure:
                (error) => Center(child: Text('Error: ${error.toString()}')),
          ),
        ),
      ],
    );
  }

  Color _getColorForTransactionType(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return Colors.green;
      case TransactionType.expense:
        return Colors.red;
      case TransactionType.transfer:
        return Colors.blue;
      case TransactionType.savings:
        return Colors.purple;
    }
  }
}
