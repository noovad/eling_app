import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';
import 'package:flutter_ui/widgets/appUtils/app_no_data_found.dart';

class BalanceSheet extends ConsumerStatefulWidget {
  final AccountType accountType;
  final Function(String title, double initialBalance) onCreate;

  const BalanceSheet({
    super.key,
    required this.accountType,
    required this.onCreate,
  });

  @override
  ConsumerState<BalanceSheet> createState() => _BalanceSheetState();
}

class _BalanceSheetState extends ConsumerState<BalanceSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final accountName = ref.read(financeNotifierProvider).accountName;
    _controller = TextEditingController(text: accountName.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _listenToReset() {
    final accountName = ref.watch(
      financeNotifierProvider.select((s) => s.accountName),
    );
    if (accountName.isPure && _controller.text.isNotEmpty) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    _listenToReset();
    final notifier = ref.read(financeNotifierProvider.notifier);
    final isFormValid = ref.watch(
      financeNotifierProvider.select((s) => s.isAccountFormValid),
    );
    final name = ref.watch(
      financeNotifierProvider.select((s) => s.accountName),
    );
    final accounts = ref.watch(
      financeNotifierProvider.select((state) => state.accounts),
    );
    final data = accounts.whenOrNull(
      success:
          (accounts) =>
              accounts
                  .where((account) => account.type == widget.accountType)
                  .toList(),
    );

    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpaces.h40,
          AppTextField(
            controller: _controller,
            label: "Account Name",
            hint: "Enter account name",
            isRequired: true,
            onChanged: (value) {
              notifier.accountNameChanged(value);
            },
            errorText: name.displayError?.message,
            maxLines: 1,
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
                        ? () => notifier.createAccount(widget.accountType)
                        : null,
                child: const Text('Create'),
              ),
            ],
          ),
          AppSpaces.h16,
          Expanded(
            child:
                data == null || data.isEmpty
                    ? Center(child: AppNoDataFound())
                    : SingleChildScrollView(
                      child: ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final account = data[index];
                          final balance = account.balance ?? 0;

                          return Card(
                            margin: EdgeInsets.only(top: 16),
                            child: ListTile(
                              title: Text(account.name),
                              subtitle: Text(
                                StringConstants.formatCurrency(balance),
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
                                        icon: Icon(Icons.delete_outline),
                                        onPressed:
                                            () => notifier.deleteAccount(
                                              account.id,
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
}
