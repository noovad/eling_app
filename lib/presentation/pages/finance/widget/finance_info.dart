import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/domain/entities/detail_summary/detail_summary.dart';
import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_card_shimmer.dart';
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
      child: summary.when(
        initial: () => _buildShimmerLayout(),
        loading: () => _buildShimmerLayout(),
        success: (data) {
          return GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 24,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3,
            children: [
              AppFinanceCard(
                title: 'Total Balance',
                leading: true,
                icon: Icons.account_balance_wallet,
                subtitle: StringConstants.formatShortCurrency(
                  data.totalBalance,
                ),
              ),

              AppFinanceCard(
                title: 'Income',
                leading: true,
                icon: Icons.trending_up,
                subtitle: StringConstants.formatShortCurrency(data.totalIncome),
                onTap:
                    () => _showDetailsDialog(
                      context,
                      'Income Details',
                      data.incomeSummaries,
                      data.totalIncome,
                    ),
              ),

              AppFinanceCard(
                title: 'Savings',
                leading: true,
                icon: Icons.move_to_inbox,
                subtitle: StringConstants.formatShortCurrency(
                  data.totalSavings,
                ),
              ),

              SizedBox.shrink(),

              AppFinanceCard(
                title: 'Expense',
                leading: true,
                icon: Icons.trending_down,
                subtitle: StringConstants.formatShortCurrency(
                  data.totalExpense,
                ),
                onTap:
                    () => _showDetailsDialog(
                      context,
                      'Expense Details',
                      data.expenseSummaries,
                      data.totalExpense,
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

  Widget _buildShimmerLayout() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3,
      children: [
        FinanceCardShimmer(
          title: 'Total Balance',
          icon: Icons.account_balance_wallet,
        ),
        FinanceCardShimmer(title: 'Income', icon: Icons.trending_up),
        FinanceCardShimmer(title: 'Savings', icon: Icons.move_to_inbox),
        const SizedBox.shrink(),
        FinanceCardShimmer(title: 'Expense', icon: Icons.trending_down),
        FinanceCardShimmer(title: 'Savings Rate', icon: Icons.percent),
      ],
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
                                    subtitle:
                                        StringConstants.formatShortCurrency(
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
