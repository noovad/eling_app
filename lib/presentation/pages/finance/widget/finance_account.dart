import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';

class FinanceAccount extends StatelessWidget {
  final List<AccountEntity>? accounts;
  const FinanceAccount({super.key, this.accounts});

  @override
  Widget build(BuildContext context) {
    if (accounts == null || accounts!.isEmpty) {
      return const Center(child: Text('No accounts available'));
    }
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      childAspectRatio: 3,
      children:
          accounts!
              .map(
                (account) => AppFinanceCard(
                  leading: false,
                  title: account.title,
                  subtitle: 'Rp ${account.balance?.toStringAsFixed(0) ?? '0'}',
                ),
              )
              .toList(),
    );
  }
}
