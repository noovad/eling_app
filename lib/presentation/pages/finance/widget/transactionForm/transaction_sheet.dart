import 'package:eling/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling/presentation/pages/finance/widget/transactionForm/button_state.dart';
import 'package:eling/presentation/pages/finance/widget/transactionForm/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionSheet extends ConsumerWidget {
  const TransactionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final type = ref.watch(
      financeNotifierProvider.select((s) => s.transactionType),
    );
    final isFormValid = ref.watch(
      financeNotifierProvider.select((s) => s.isFormValid),
    );

    return Padding(
      padding: AppPadding.all16,
      child: Column(
        children: [
          AppSpaces.h40,
          ButtonState(onChanged: notifier.transactionTypeChanged),
          TransactionForm(type: type),
          AppSpaces.h40,
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(
                onPressed:
                    isFormValid ? () => notifier.createTransaction() : null,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
