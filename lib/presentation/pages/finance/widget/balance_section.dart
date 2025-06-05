import 'package:eling_app/presentation/pages/finance/widget/balance_sheet.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_account.dart';
import 'package:eling_app/presentation/pages/finance/widget/transaction_category_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appPopOver/app_pop_over.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all12,
      child: AppTabs(
        length: 2,
        tabBar: [Tab(text: 'Balance'), Tab(text: 'Savings')],
        tabBarView: [FinanceAccount(), FinanceAccount()],
        tabBarChild: Card(
          color: Theme.of(context).colorScheme.primary,
          child: AppPopOver(
            trigger: SizedBox.square(
              dimension: 60,
              child: Icon(Icons.more_horiz, color: Colors.white, size: 30),
            ),
            content: Padding(
              padding: AppPadding.all16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  _buildActionButton(
                    context,
                    '+ Balance Account',
                    () => _showSheet(context, const BalanceSheet()),
                  ),
                  _buildActionButton(
                    context,
                    '+ Savings Account',
                    () => _showSheet(context, const BalanceSheet()),
                  ),
                  _buildActionButton(
                    context,
                    'Transaction Category',
                    () => _showSheet(context, const TransactionCategorySheet()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        alignment: Alignment.centerLeft,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  void _showSheet(BuildContext context, Widget content) {
    appSheet(
      context: context,
      side: SheetSide.left,
      builder: (context) => content,
    );
  }
}
