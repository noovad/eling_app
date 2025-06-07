import 'package:eling/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling/presentation/pages/finance/widget/account/account_section.dart';
import 'package:eling/presentation/pages/finance/widget/finance_info.dart';
import 'package:eling/presentation/pages/finance/widget/table/transaction_tabs.dart';
import 'package:eling/presentation/utils/result_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancePage extends ConsumerWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);

    ref.listen(
      financeNotifierProvider.select((state) => state.saveResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        action: ForAction.save,
        resetAction: notifier.resetIsSaving,
      ),
    );

    ref.listen(
      financeNotifierProvider.select((state) => state.deleteResult),
      (previous, current) => ResultHandler.handleResult(
        context: context,
        result: current,
        action: ForAction.delete,
        resetAction: notifier.resetIsDeleting,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double tableWidth = screenWidth - 700;
          if (tableWidth < 700) tableWidth = 700;
          double totalContentWidth = tableWidth + 700;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: totalContentWidth),
              child: Row(
                children: [
                  SizedBox(width: tableWidth, child: TransactionTabs()),
                  SizedBox(
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: const [
                        FinanceInfo(),
                        Divider(thickness: 2, indent: 12, endIndent: 12),
                        Expanded(child: AccountSection()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
