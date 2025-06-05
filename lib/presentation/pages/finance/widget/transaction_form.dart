import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
import 'package:eling_app/core/utils/constants/string_constants.dart';
import 'package:eling_app/domain/entities/account/account.dart';
import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:eling_app/presentation/widgets/input_format_rupiah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';
import 'package:flutter_ui/widgets/appField/app_date_field.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class TransactionForm extends ConsumerWidget {
  final TransactionType type;
  const TransactionForm({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(financeNotifierProvider.notifier);
    final title = ref.watch(
      financeNotifierProvider.select((s) => s.transactionTitle),
    );
    final date = ref.watch(financeNotifierProvider.select((s) => s.date));
    final amount = ref.watch(financeNotifierProvider.select((s) => s.amount));
    final source = ref.watch(financeNotifierProvider.select((s) => s.source));
    final target = ref.watch(financeNotifierProvider.select((s) => s.target));
    final category = ref.watch(
      financeNotifierProvider.select((s) => s.category),
    );
    final transactionCategories = ref.watch(
      financeNotifierProvider.select((s) => s.transactionCategories),
    );

    final categoryItems = transactionCategories.whenOrNull(
      success:
          (categories) =>
              categories
                  .map(
                    (category) =>
                        DropdownItem(id: category.id, label: category.name),
                  )
                  .toList(),
    );

    final accounts = ref.watch(
      financeNotifierProvider.select((state) => state.accounts),
    );

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

    return Column(
      children: [
        AppSpaces.h24,
        AppTextField(
          label: 'Title',
          hint: 'Enter title...',
          errorText: title.displayError?.message,
          isRequired: true,
          onChanged: notifier.titleChanged,
          initialValue: title.value,
          maxLines: 1,
        ),
        AppSpaces.h24,
        AppDateField(
          label: 'Date',
          hint: 'Select date...',
          initialValue:
              date.value.isNotEmpty ? DateTime.tryParse(date.value) : null,
          onChanged: (date) {
            notifier.dateChanged(date.toIso8601String());
          },
          isRequired: true,
          errorText: date.displayError?.message,
        ),
        AppSpaces.h24,
        AppTextField(
          label: 'Amount',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ],
          isRequired: true,
          prefixText: 'Rp ',
          hint: 'Enter amount...',
          errorText: amount.displayError?.message,
          onChanged: notifier.amountChanged,
        ),
        AppSpaces.h24,
        Visibility(
          visible: type == TransactionType.expense,
          maintainSize: false,
          maintainAnimation: false,
          maintainState: true,
          child: Column(
            children: [
              AppDropdown<String>(
                items: categoryItems ?? [],
                label: 'Category',
                withLabel: true,
                showUnselect: false,
                hint: 'Select category...',
                isRequired: true,
                errorText: category.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.categoryChanged(item.label);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        Visibility(
          visible:
              type != TransactionType.income || type == TransactionType.expense,
          maintainSize: false,
          maintainAnimation: false,
          maintainState: true,
          child: Column(
            children: [
              AppDropdown<String>(
                items:
                    balanceAccounts
                        ?.map(
                          (account) => DropdownItem(
                            id: account.id,
                            label:
                                "${account.name} (${StringConstants.formatCurrency(account.balance ?? 0)})",
                          ),
                        )
                        .toList() ??
                    [],
                label: 'Source',
                withLabel: true,
                showUnselect: false,
                hint: 'Select source...',
                isRequired: true,
                errorText: source.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.sourceChanged(item.id);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),

        Visibility(
          visible: type == TransactionType.savings,
          maintainSize: false,
          maintainAnimation: false,
          maintainState: true,
          child: Column(
            children: [
              AppDropdown<String>(
                items:
                    savingsAccounts
                        ?.map(
                          (account) => DropdownItem(
                            id: account.id,
                            label:
                                "${account.name} (${StringConstants.formatCurrency(account.balance ?? 0)})",
                          ),
                        )
                        .toList() ??
                    [],
                label: 'Target Savings Account',
                withLabel: true,
                showUnselect: false,
                hint: 'Select target...',
                isRequired: true,
                errorText: target.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.targetChanged(item.id);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        Visibility(
          visible:
              type == TransactionType.income ||
              type == TransactionType.transfer,
          maintainSize: false,
          maintainAnimation: false,
          maintainState: true,
          child: Column(
            children: [
              AppDropdown<String>(
                items:
                    balanceAccounts
                        ?.map(
                          (account) => DropdownItem(
                            id: account.id,
                            label:
                                "${account.name} (${StringConstants.formatCurrency(account.balance ?? 0)})",
                          ),
                        )
                        .toList() ??
                    [],
                label: 'Target Balance Account',
                withLabel: true,
                showUnselect: false,
                hint: 'Select target...',
                isRequired: true,
                errorText: target.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.targetChanged(item.id);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        AppTextField(
          label: 'Description',
          maxLines: 3,
          hint: 'Enter description...',
          onChanged: notifier.descriptionChanged,
        ),
      ],
    );
  }
}
