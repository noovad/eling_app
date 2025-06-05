import 'package:eling_app/presentation/pages/finance/widget/balance_section.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_info.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_table.dart';
import 'package:flutter/material.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(width: tableWidth, child: FinanceTable()),
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: const [
                        FinanceInfo(),
                        Divider(thickness: 2, indent: 12, endIndent: 12),
                        Expanded(child: BalanceSection()),
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
