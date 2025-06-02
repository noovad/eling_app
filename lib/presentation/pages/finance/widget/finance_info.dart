import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';

class FinanceInfo extends StatelessWidget {
  const FinanceInfo({super.key});

  @override
  Widget build(BuildContext context) {
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
          subtitle: 'Rp 10.000 K',
        ),
        AppFinanceCard(
          title: 'Income',
          leading: true,
          icon: Icons.trending_up,
          subtitle: 'Rp 10.000 K',
          onTap: () {
            // Handle tap
          },
        ),
        AppFinanceCard(
          title: 'Savings',
          leading: true,
          icon: Icons.move_to_inbox,
          subtitle: 'Rp 10.000 K',
        ),
        SizedBox.shrink(),

        AppFinanceCard(
          title: 'Expense',
          leading: true,
          icon: Icons.trending_down,
          subtitle: 'Rp 10.000 K',
          onTap: () {
            // Handle tap
          },
        ),
        AppFinanceCard(
          title: 'Additional income.',
          leading: true,
          highlight: true,
          icon: Icons.rocket,
          subtitle: 'Is Required',
        ),
      ],
    );
  }
}
