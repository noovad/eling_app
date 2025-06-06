import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/domain/entities/detail_summary/detail_summary.dart';
import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';

class FinanceInfo extends ConsumerWidget {
  const FinanceInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(
      financeNotifierProvider.select((state) => state.financeSummary),
    );

    return Padding(
      padding: AppPadding.all12,
      child: summary.whenOrNull(
        success: (data) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 4,
            children: [
              SizedBox.shrink(),
              AppFinanceCard(
                title: 'Total Balance',
                leading: true,
                highlight: true,
                icon: Icons.account_balance_wallet,
                subtitle: StringConstants.formatCurrency(data.totalBalance),
                titleInfo: 'All',
              ),
              AppFinanceCard(
                title: 'Income',
                leading: true,
                icon: Icons.trending_up,
                subtitle: StringConstants.formatCurrency(data.totalIncome),
                onTap:
                    () => _showDetailsDialog(
                      context,
                      'Income Details',
                      data.incomeSummaries,
                      data.totalIncome,
                    ),
                titleInfo: 'Month',
              ),
              AppFinanceCard(
                title: 'Savings',
                leading: true,
                icon: Icons.move_to_inbox,
                subtitle: StringConstants.formatCurrency(data.totalSavings),
                titleInfo: 'Month',
              ),
              AppFinanceCard(
                title: 'Expense',
                leading: true,
                icon: Icons.trending_down,
                subtitle: StringConstants.formatCurrency(data.totalExpense),
                titleInfo: 'Month',

                onTap:
                    () => _showDetailsDialog(
                      context,
                      'Expense Details',
                      data.expenseSummaries,
                      data.totalExpense,
                    ),
              ),
              AppFinanceCard(
                title: 'Net Balance',
                leading: true,
                icon: Icons.output,
                subtitle: StringConstants.formatCurrency(
                  data.totalIncome - data.totalExpense,
                ),
                titleInfo: 'Month',
                highlight: true,
              ),
            ],
          );
        },
        failure: (error) => Center(child: Text(error)),
      ),
    );
  }

  void _showDetailsDialog(
    BuildContext context,
    String title,
    List<DetailSummaryEntity> summaries,
    double total,
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
                        crossAxisCount: 2,
                        crossAxisSpacing: 24,
                        shrinkWrap: true,
                        childAspectRatio: 4,
                        children:
                            summaries
                                .map(
                                  (summary) => AppFinanceCard(
                                    leading: false,
                                    title: summary.category,
                                    subtitle: StringConstants.formatCurrency(
                                      summary.amount,
                                    ),
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
