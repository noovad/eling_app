import 'package:eling_app/core/providers/notifier/finance_notifier_provider.dart';
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
    final description = ref.watch(
      financeNotifierProvider.select((s) => s.description),
    );
    final transactionCategories = ref.watch(
      financeNotifierProvider.select((s) => s.transactionCategories),
    );

    final categoryItems =
        transactionCategories.whenOrNull(
          success:
              (categories) =>
                  categories
                      .map(
                        (category) =>
                            DropdownItem(id: category.id, label: category.name),
                      )
                      .toList(),
        ) ??
        const [];

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
          onChanged: notifier.updateTitle,
          initialValue: title.value,
        ),
        AppSpaces.h24,
        AppDateField(
          label: 'Date',
          hint: 'Select date...',
          initialValue:
              date.value.isNotEmpty ? DateTime.tryParse(date.value) : null,
          onChanged: (DateTime? date) {
            if (date != null) {
              notifier.updateDate(date.toIso8601String());
            }
          },
          isRequired: true,
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
          initialValue: amount.value,
          errorText: amount.displayError?.message,
          onChanged: notifier.updateAmount,
        ),
        AppSpaces.h24,
        Visibility(
          visible: type != TransactionType.income,
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
                                "${account.title} (${_formatBalance(account.balance ?? 0)})",
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
                    notifier.updateSource(item.id);
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
                                "${account.title} (${_formatBalance(account.balance ?? 0)})",
                          ),
                        )
                        .toList() ??
                    [],
                label: 'Target',
                withLabel: true,
                showUnselect: false,
                hint: 'Select target...',
                isRequired: true,
                errorText: target.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.updateTarget(item.id);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        Visibility(
          visible: type == TransactionType.income,
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
                                "${account.title} (${_formatBalance(account.balance ?? 0)})",
                          ),
                        )
                        .toList() ??
                    [],
                label: 'Target',
                withLabel: true,
                showUnselect: false,
                hint: 'Select target...',
                isRequired: true,
                errorText: target.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.updateTarget(item.id);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        Visibility(
          visible: type == TransactionType.transfer,
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
                                "${account.title} (${_formatBalance(account.balance ?? 0)})",
                          ),
                        )
                        .toList() ??
                    [],
                label: 'Target',
                withLabel: true,
                showUnselect: false,
                hint: 'Select target...',
                isRequired: true,
                errorText: target.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.updateTarget(item.id);
                  }
                },
              ),
              AppSpaces.h24,
            ],
          ),
        ),
        Visibility(
          visible: type == TransactionType.expense,
          maintainSize: false,
          maintainAnimation: false,
          maintainState: true,
          child: Column(
            children: [
              AppDropdown<String>(
                items: categoryItems,
                label: 'Category',
                withLabel: true,
                showUnselect: false,
                hint: 'Select category...',
                isRequired: true,
                errorText: category.displayError?.message,
                onChanged: (DropdownItem<String>? item) {
                  if (item != null) {
                    notifier.updateCategory(item.id);
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
          initialValue: description,
          onChanged: notifier.updateDescription,
        ),
      ],
    );
  }

  String _formatBalance(double balance) {
    final formattedBalance = balance
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
    return 'Rp $formattedBalance';
  }
}
