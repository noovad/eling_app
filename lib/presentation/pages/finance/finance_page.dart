import 'package:eling_app/presentation/pages/finance/widget/balance_section.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_info.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.all16,
        child: Row(
          children: [
            Expanded(child: FinanceTable()),
            AppSpaces.w24,
            Container(
              color: Theme.of(context).colorScheme.surface,
              width: 700,
              child: Column(
                spacing: 24,
                children: [
                  FinanceInfo(),
                  Divider(thickness: 2),
                  SizedBox(height: 300, child: BalanceSection()),
                  Divider(thickness: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
