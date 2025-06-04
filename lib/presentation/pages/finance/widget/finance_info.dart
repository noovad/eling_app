import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';

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
          onTap:
              () => showDialog<String>(
                context: context,
                builder:
                    (BuildContext context) => Dialog(
                      child: Container(
                        width: 700,
                        constraints: BoxConstraints(maxHeight: 270),
                        child: SingleChildScrollView(
                          child: GridView.count(
                            padding: AppPadding.all16,
                            crossAxisCount: 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 16,
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
                          ),
                        ),
                      ),
                    ),
              ),
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
          onTap:
              () => showDialog<String>(
                context: context,
                builder:
                    (BuildContext context) => Dialog(
                      child: Container(
                        width: 700,
                        constraints: BoxConstraints(maxHeight: 270),
                        child: SingleChildScrollView(
                          child: GridView.count(
                            padding: AppPadding.all16,
                            crossAxisCount: 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 16,
                            shrinkWrap: true,
                            childAspectRatio: 3,
                            children: [
                              AppFinanceCard(
                                leading: false,
                                title: 'Dompet',
                                subtitle: 'Rp 5 Jt',
                                trailing: true,
                                trailingText: '15%',
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
                          ),
                        ),
                      ),
                    ),
              ),
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
