import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabs(
      length: 2,
      tabBar: [Tab(text: 'Saldo'), Tab(text: 'Investment')],
      tabBarView: [
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 24,
          shrinkWrap: true,
          childAspectRatio: 3,
          children: [
            AppFinanceCard(
              leading: false,
              title: 'Dompet',
              subtitle: 'Rp 5.000.000',
              icon: Icons.account_balance_wallet,
              onTap: () {
                // Handle tap
              },
            ),
            AppFinanceCard(
              leading: false,
              title: 'BSI Transaction',
              subtitle: 'Rp 5.000.000',
              icon: Icons.account_balance_wallet,
              onTap: () {
                // Handle tap
              },
            ),
            AppFinanceCard(
              leading: false,
              title: 'BSI Saving',
              subtitle: 'Rp 5.000.000',
              icon: Icons.account_balance_wallet,
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
        Center(child: Text('Expense Table')),
      ],
      tabBarChild: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Theme.of(context).colorScheme.shadow,
        type: MaterialType.card,
        color: Theme.of(context).colorScheme.primary,
        child: SizedBox.square(
          dimension: 60,
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
