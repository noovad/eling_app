import 'package:eling_app/presentation/pages/finance/widget/button_state.dart';
import 'package:eling_app/presentation/widgets/input_format_rupiah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';
import 'package:flutter_ui/widgets/appField/app_date_field.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class TransactionSheet extends StatefulWidget {
  const TransactionSheet({super.key});

  @override
  State<TransactionSheet> createState() => _TransactionSheetState();
}

class _TransactionSheetState extends State<TransactionSheet> {
  final type = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all16,
      child: Column(
        children: [
          AppSpaces.h40,
          ButtonState(
            onChanged: (String selectedCategory) {
              setState(() {
                type.text = selectedCategory;
              });
            },
          ),
          AppSpaces.h24,
          AppTextField(
            label: 'Title',
            hint: 'Enter title...',
            errorText: null,
            isRequired: true,
            onChanged: (p0) {},
          ),
          AppSpaces.h24,
          AppDateField(
            label: 'Date',
            hint: 'Select date...',
            initialValue: DateTime.now(),
            onChanged: (date) {},
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
          ),
          AppSpaces.h24,
          Visibility(
            visible: type.text != 'Income',
            maintainSize: false,
            maintainAnimation: false,
            maintainState: true,
            child: Column(
              children: [
                AppDropdown<String>(
                  items: const [
                    DropdownItem(id: 'Bank', label: 'Bank'),
                    DropdownItem(id: 'Cash', label: 'Cash'),
                    DropdownItem(id: 'E-Wallet', label: 'E-Wallet'),
                    DropdownItem(id: 'Other', label: 'Other'),
                  ],
                  label: 'Source',
                  withLabel: true,
                  showUnselect: false,
                  hint: 'Select source...',
                ),
                AppSpaces.h24,
              ],
            ),
          ),
          Visibility(
            visible: type.text == 'Savings' || type.text == 'Income',
            maintainSize: false,
            maintainAnimation: false,
            maintainState: true,
            child: Column(
              children: [
                AppDropdown<String>(
                  items: const [
                    DropdownItem(id: 'Invest', label: 'Invest'),
                    DropdownItem(id: 'Tabungan', label: 'Tabungan'),
                    DropdownItem(id: 'Deposito', label: 'Deposito'),
                    DropdownItem(id: 'Lainnya', label: 'Lainnya'),
                  ],
                  label: 'Target',
                  withLabel: true,
                  showUnselect: false,
                  hint: 'Select target...',
                ),
                AppSpaces.h24,
              ],
            ),
          ),
          Visibility(
            visible: type.text == 'Transfer',
            maintainSize: false,
            maintainAnimation: false,
            maintainState: true,
            child: Column(
              children: [
                AppDropdown<String>(
                  items: const [
                    DropdownItem(id: 'Bank', label: 'Bank'),
                    DropdownItem(id: 'Cash', label: 'Cash'),
                    DropdownItem(id: 'E-Wallet', label: 'E-Wallet'),
                    DropdownItem(id: 'Other', label: 'Other'),
                  ],
                  label: 'Target',
                  withLabel: true,
                  showUnselect: false,
                  hint: 'Select target...',
                ),
                AppSpaces.h24,
              ],
            ),
          ),
          Visibility(
            visible: type.text == 'Expenses',
            maintainSize: false,
            maintainAnimation: false,
            maintainState: true,
            child: Column(
              children: [
                AppDropdown<String>(
                  items: const [
                    DropdownItem(id: 'Food', label: 'Food'),
                    DropdownItem(id: 'Transport', label: 'Transport'),
                    DropdownItem(id: 'Shopping', label: 'Shopping'),
                    DropdownItem(id: 'Bills', label: 'Bills'),
                    DropdownItem(id: 'Entertainment', label: 'Entertainment'),
                    DropdownItem(id: 'Health', label: 'Health'),
                    DropdownItem(id: 'Other', label: 'Other'),
                  ],
                  label: 'Category',
                  withLabel: true,
                  showUnselect: false,
                  hint: 'Select category...',
                ),
                AppSpaces.h24,
              ],
            ),
          ),
          AppTextField(
            label: 'Description',
            maxLines: 3,
            hint: 'Enter description...',
          ),
          AppSpaces.h40,
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(onPressed: () {}, child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }
}
