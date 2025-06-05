import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appUtils/app_no_data_found.dart';

class FinanceAccount extends ConsumerWidget {
  final AccountType accountType;
  const FinanceAccount({super.key, required this.accountType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(
      financeNotifierProvider.select((state) => state.accounts),
    );

    final data = accounts.whenOrNull(
      success:
          (accounts) =>
              accounts.where((account) => account.type == accountType).toList(),
    );

    if (data == null || data.isEmpty) {
      return const Center(child: AppNoDataFound());
    }
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      childAspectRatio: 3,
      children:
          data
              .map(
                (account) => AppFinanceCard(
                  leading: false,
                  title: account.name,
                  subtitle: 'Rp ${account.balance?.toStringAsFixed(0) ?? '0'}',
                ),
              )
              .toList(),
    );
  }
}
