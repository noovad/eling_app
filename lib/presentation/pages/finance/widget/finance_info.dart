import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/domain/entities/detail_summary/detail_summary.dart';
import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:intl/intl.dart';

class FinanceInfo extends ConsumerWidget {
  const FinanceInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(
      financeNotifierProvider.select((state) => state.financeSummary),
    );

    final currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Padding(
      padding: AppPadding.all12,
      child: summary.when(
        initial: () => const Center(child: Text('No data available')),
        loading: () => const Center(child: CircularProgressIndicator()),
        success: (data) {
          return GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 24,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 3,
            children: [
              AppFinanceCard(
                title: 'Total Balance',
                leading: true,
                icon: Icons.account_balance_wallet,
                subtitle: currencyFormatter.format(data.totalBalance),
              ),

              AppFinanceCard(
                title: 'Income',
                leading: true,
                icon: Icons.trending_up,
                subtitle: currencyFormatter.format(data.totalIncome),
                onTap:
                    () => _showDetailsDialog(
                      context,
                      'Income Details',
                      data.incomeSummaries,
                      data.totalIncome,
                      currencyFormatter,
                    ),
              ),

              AppFinanceCard(
                title: 'Savings',
                leading: true,
                icon: Icons.move_to_inbox,
                subtitle: currencyFormatter.format(data.totalSavings),
              ),

              SizedBox.shrink(),

              AppFinanceCard(
                title: 'Expense',
                leading: true,
                icon: Icons.trending_down,
                subtitle: currencyFormatter.format(data.totalExpense),
                onTap:
                    () => _showDetailsDialog(
                      context,
                      'Expense Details',
                      data.expenseSummaries,
                      data.totalExpense,
                      currencyFormatter,
                    ),
              ),

              AppFinanceCard(
                title: 'Savings Rate',
                leading: true,
                highlight: data.totalIncome <= data.totalExpense,
                icon: Icons.percent,
                subtitle:
                    data.totalIncome > 0
                        ? '${((data.totalIncome - data.totalExpense) / data.totalIncome * 100).toStringAsFixed(0)}%'
                        : 'N/A',
              ),
            ],
          );
        },
        failure:
            (error) => Center(
              child: Text('Error loading financial data: ${error.toString()}'),
            ),
      ),
    );
  }

  void _showDetailsDialog(
    BuildContext context,
    String title,
    List<DetailSummaryEntity> summaries,
    double total,
    NumberFormat formatter,
  ) {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => Dialog(
            child: Container(
              width: 700,
              constraints: BoxConstraints(maxHeight: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.count(
                        padding: AppPadding.all16,
                        crossAxisCount: 3,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 16,
                        shrinkWrap: true,
                        childAspectRatio: 3,
                        children:
                            summaries
                                .map(
                                  (summary) => AppFinanceCard(
                                    leading: false,
                                    title: summary.category,
                                    subtitle: formatter.format(summary.amount),
                                    trailing: true,
                                    trailingText:
                                        '${summary.percentage.toStringAsFixed(0)}%',
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
