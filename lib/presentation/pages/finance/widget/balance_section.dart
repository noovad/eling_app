import 'package:eling_app/presentation/pages/finance/widget/balance_sheet.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appPopOver/app_pop_over.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTabs(
      length: 2,
      tabBar: [Tab(text: 'Balance'), Tab(text: 'Savings')],
      tabBarView: [FinanceAccount(), FinanceAccount()],
      tabBarChild: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Theme.of(context).colorScheme.shadow,
        type: MaterialType.card,
        color: Theme.of(context).colorScheme.primary,
        child: AppPopOver(
          content: Padding(
            padding: AppPadding.all16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                ElevatedButton(
                  onPressed: () {
                    appSheet(
                      context: context,
                      side: SheetSide.left,
                      builder: (context) {
                        return BalanceSheet();
                      },
                    );
                  },
                  child: const Text('Balance'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    appSheet(
                      context: context,
                      side: SheetSide.left,
                      builder: (context) {
                        return BalanceSheet();
                      },
                    );
                  },
                  child: const Text('Savings'),
                ),
              ],
            ),
          ),
          trigger: SizedBox.square(
            dimension: 60,
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}
