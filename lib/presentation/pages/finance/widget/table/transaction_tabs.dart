import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/presentation/pages/finance/widget/table/monthly_table.dart';
import 'package:eling_app/presentation/pages/finance/widget/transactionForm/transaction_sheet.dart';
import 'package:eling_app/presentation/pages/finance/widget/table/yearly_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class TransactionTabs extends ConsumerWidget {
  const TransactionTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    return Padding(
      padding: AppPadding.all12,
      child: AppTabs(
        length: 2,
        tabBar: [Tab(text: 'Monthly'), Tab(text: 'Yearly')],
        tabBarView: [MonthlyTable(), YearlyTable()],
        tabBarChild: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          shadowColor: Theme.of(context).colorScheme.shadow,
          color: Theme.of(context).colorScheme.primary,
          child: InkWell(
            onTap: () {
              notifier.resetTransactionForm();
              appSheet(
                context: context,
                side: SheetSide.right,
                builder: (context) {
                  return TransactionSheet();
                },
              );
            },
            child: SizedBox.square(
              dimension: 60,
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
