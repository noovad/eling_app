import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/presentation/pages/finance/widget/table/transaction_type_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDialog/app_dialog.dart';
import 'package:flutter_ui/widgets/appNav/app_date_nav.dart';
import 'package:flutter_ui/widgets/appUtils/app_no_data_found.dart';
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
                  onChanged: (type) => notifier.updateFilter(type: type),
                ),
              ),
            ),
            Expanded(
              child: AppDateNav(
                onChange: (date) => notifier.updateFilter(date: date),
              ),
            ),
          ],
        ),
        AppSpaces.h24,
        Flexible(
          child: SingleChildScrollView(
            child: DataTable(
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
                  columnWidth: FlexColumnWidth(1),
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
                        'Amount',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                DataColumn(
                  headingRowAlignment: MainAxisAlignment.center,
                  label: Row(
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
              ],
              rows: transactions.when(
                initial: () => [],
                loading: () => [],
                failure: (error) => [],
                success:
                    (data) =>
                        data.map((transaction) {
                          final formattedDate = DateFormat(
                            'dd MMM yyyy',
                          ).format(transaction.date);

                          return DataRow(
                            cells: [
                              DataCell(Text(formattedDate)),
                              DataCell(
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        transaction.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    AppSpaces.w8,
                                    Icon(
                                      transaction.type == TransactionType.income
                                          ? Icons.trending_up
                                          : transaction.type ==
                                              TransactionType.expense
                                          ? Icons.trending_down
                                          : transaction.type ==
                                              TransactionType.transfer
                                          ? Icons.compare_arrows
                                          : Icons.move_to_inbox,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text(
                                  transaction.category ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              DataCell(
                                Text(
                                  StringConstants.formatCurrency(
                                    transaction.amount,
                                  ),
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                                                        Navigator.of(
                                                          context,
                                                        ).pop(),
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
              ),
            ),
          ),
        ),
        transactions.when(
          initial:
              () => Expanded(
                child: const Center(
                  child: Text('Select a date to view transactions'),
                ),
              ),
          loading:
              () => Expanded(
                child: const Center(child: CircularProgressIndicator()),
              ),
          failure: (message) {
            return Expanded(child: Text(message.toString()));
          },
          success: (value) {
            if (value.isEmpty) {
              return Expanded(child: AppNoDataFound());
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
