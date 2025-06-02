import 'package:eling_app/presentation/widgets/input_format_rupiah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';
import 'package:flutter_ui/widgets/appField/app_date_field.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class TransactionSheet extends StatelessWidget {
  const TransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all16,
      child: Column(
        spacing: 16,
        children: [
          AppSpaces.h24,
          Row(
            spacing: 12,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Income')),
              ElevatedButton(onPressed: () {}, child: const Text('Expenses')),
              ElevatedButton(onPressed: () {}, child: const Text('Savings')),
              ElevatedButton(onPressed: () {}, child: const Text('Transfer')),
            ],
          ),
          AppTextField(label: 'Title'),
          AppDateField(
            label: 'Date',
            hint: 'Select date...',
            initialValue: DateTime.now(),
            onChanged: (date) {
              // Handle date change
            },
          ),
          AppTextField(
            label: 'Amount',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            prefixText: 'Rp ',
            hint: 'Enter amount...',
          ),
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
          AppTextField(
            label: 'Description',
            maxLines: 3,
            hint: 'Enter description...',
          ),
        ],
      ),
    );
  }
}
