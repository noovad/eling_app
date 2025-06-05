import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class BalanceSheet extends ConsumerStatefulWidget {
  final AccountType accountType;
  final Function(String title, double initialBalance) onCreate;
  final List<AccountEntity>? accounts;

  const BalanceSheet({
    super.key,
    required this.accountType,
    required this.onCreate,
    this.accounts,
  });

  @override
  ConsumerState<BalanceSheet> createState() => _BalanceSheetState();
}

class _BalanceSheetState extends ConsumerState<BalanceSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final accountTitle = ref.watch(
      financeNotifierProvider.select((s) => s.newAccountTitle),
    );
    final accountBalance = ref.watch(
      financeNotifierProvider.select((s) => s.newAccountBalance),
    );
    final isFormValid = accountTitle.isNotEmpty;

    if (_nameController.text != accountTitle) {
      _nameController.text = accountTitle;
    }

    if (_balanceController.text != accountBalance.toString() &&
        accountBalance > 0) {
      _balanceController.text = accountBalance.toString();
    }

    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpaces.h40,
          AppTextField(
            label: "Account Name",
            hint: "Enter account name",
            isRequired: true,
            controller: _nameController,
            onChanged: notifier.updateNewAccountTitle,
          ),
          AppSpaces.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  notifier.resetAccountForm();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(
                onPressed:
                    isFormValid
                        ? () {
                          notifier.createAccount(
                            accountTitle,
                            widget.accountType,
                          );
                        }
                        : null,
                child: const Text('Create'),
              ),
            ],
          ),
          AppSpaces.h16,
          Expanded(
            child: SingleChildScrollView(
              child:
                  widget.accounts == null || widget.accounts!.isEmpty
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('No accounts found'),
                        ),
                      )
                      : ListView.builder(
                        itemCount: widget.accounts!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final account = widget.accounts![index];

                          final balance = account.balance ?? 0;
                          final formattedBalance =
                              'Rp ${balance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

                          return Card(
                            margin: EdgeInsets.only(top: AppSizes.dimen16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.25),
                                width: 1,
                              ),
                            ),
                            elevation: 4,
                            shadowColor: Theme.of(context).colorScheme.outline,
                            child: ListTile(
                              title: Text(account.title),
                              subtitle: Text(
                                formattedBalance,
                                style: Theme.of(
                                  context,
                                ).textTheme.labelLarge?.copyWith(
                                  color:
                                      balance < 0 ? Colors.red : Colors.green,
                                ),
                              ),
                              trailing:
                                  balance == 0
                                      ? IconButton(
                                        icon: const Icon(Icons.delete_outline),
                                        onPressed:
                                            () => _showDeleteConfirmation(
                                              context,
                                              account,
                                            ),
                                      )
                                      : null,
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, AccountEntity account) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: Text('Are you sure you want to delete ${account.title}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final notifier = ref.read(financeNotifierProvider.notifier);
                  notifier.deleteAccount(account.id);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}
