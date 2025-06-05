import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/presentation/pages/finance/widget/balance_sheet.dart';
import 'package:eling_app/presentation/pages/finance/widget/finance_account.dart';
import 'package:eling_app/presentation/pages/finance/widget/transaction_category_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/widgets/appPopOver/app_pop_over.dart';
import 'package:flutter_ui/widgets/appSheet/app_sheet.dart';
import 'package:flutter_ui/widgets/appTabs/app_tabs.dart';

class BalanceSection extends ConsumerWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final accounts = ref.watch(
      financeNotifierProvider.select((state) => state.accounts),
    );

    // Get balance and savings accounts for the tabs
    final balanceAccounts = accounts.whenOrNull(
      success:
          (accounts) =>
              accounts
                  .where((account) => account.type == AccountType.balance)
                  .toList(),
    );

    final savingsAccounts = accounts.whenOrNull(
      success:
          (accounts) =>
              accounts
                  .where((account) => account.type == AccountType.saving)
                  .toList(),
    );

    return Padding(
      padding: AppPadding.all12,
      child: AppTabs(
        length: 2,
        tabBar: [Tab(text: 'Balance'), Tab(text: 'Savings')],
        tabBarView: [
          FinanceAccount(accounts: balanceAccounts ?? []),
          FinanceAccount(accounts: savingsAccounts ?? []),
        ],
        tabBarChild: Card(
          color: Theme.of(context).colorScheme.primary,
          child: AppPopOver(
            trigger: SizedBox.square(
              dimension: 60,
              child: Icon(Icons.more_horiz, color: Colors.white, size: 30),
            ),
            content: Padding(
              padding: AppPadding.all16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  _buildActionButton(
                    context,
                    '+ Balance Account',
                    () => _showSheet(
                      context,
                      BalanceSheet(
                        accountType: AccountType.balance,
                        onCreate: (title, initialBalance) {
                          notifier.createAccount(
                            title,
                            AccountType.balance,
                          );
                        },
                        // Only pass accounts of the relevant type to avoid filtering twice
                        accounts: balanceAccounts ?? [],
                      ),
                    ),
                  ),
                  _buildActionButton(
                    context,
                    '+ Savings Account',
                    () => _showSheet(
                      context,
                      BalanceSheet(
                        accountType: AccountType.saving,
                        onCreate: (title, initialBalance) {
                          notifier.createAccount(
                            title,
                            AccountType.saving,
                          );
                        },
                        // Only pass accounts of the relevant type to avoid filtering twice
                        accounts: savingsAccounts ?? [],
                      ),
                    ),
                  ),
                  _buildActionButton(
                    context,
                    'Transaction Category',
                    () => _showSheet(
                      context,
                      TransactionCategorySheet(
                        onCategoryCreate: (name) {
                          notifier.createTransactionCategory(name);
                        },
                        onCategoryDelete: (id) {
                          notifier.deleteTransactionCategory(id);
                        },
                        categories: ref.watch(
                          financeNotifierProvider.select(
                            (state) =>
                                state.transactionCategories.whenOrNull(
                                  success: (categories) => categories,
                                ) ??
                                [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        alignment: Alignment.centerLeft,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  void _showSheet(BuildContext context, Widget content) {
    appSheet(
      context: context,
      side: SheetSide.left,
      builder: (context) => content,
    );
  }
}
