import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';

class FinanceAccount extends StatelessWidget {
  const FinanceAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      childAspectRatio: 3,
      children: [
        AppFinanceCard(
          leading: false,
          title: 'Dompet',
          subtitle: 'Rp 5.000.000',
        ),
        AppFinanceCard(
          leading: false,
          title: 'BSI Transaction',
          subtitle: 'Rp 5.000.000',
        ),
        AppFinanceCard(
          leading: false,
          title: 'BSI Saving',
          subtitle: 'Rp 5.000.000',
        ),
      ],
    );
  }
}
