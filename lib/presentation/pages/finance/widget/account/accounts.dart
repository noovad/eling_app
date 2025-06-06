import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/presentation/pages/finance/notifier/finance_notifier.dart';
import 'package:eling_app/presentation/pages/finance/widget/app_finance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/widgets/appUtils/app_no_data_found.dart';

class Accounts extends ConsumerWidget {
  final AccountType accountType;
  const Accounts({super.key, required this.accountType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final data = ref.watch(
      financeNotifierProvider.select(
        (state) => state.accounts.whenOrNull(
          success:
              (accounts) =>
                  accounts
                      .where((account) => account.type == accountType)
                      .toList(),
        ),
      ),
    );

    ref.listen<FinanceState>(financeNotifierProvider, (prev, next) {
      if (prev?.deleteResult != next.deleteResult) {
        next.deleteResult.whenOrNull(success: (_) => notifier.getAccounts());
      }
      if (prev?.saveResult != next.saveResult) {
        next.saveResult.whenOrNull(success: (_) => notifier.getAccounts());
      }
    });

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
                  subtitle: StringConstants.formatCurrency(
                    account.balance ?? 0,
                  ),
                ),
              )
              .toList(),
    );
  }
}
