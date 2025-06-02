import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';

class TransactionTypeDropdown extends StatelessWidget {
  const TransactionTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDropdown<Object?>(
      showUnselect: false,
      withLabel: false,
      initialValue: const DropdownItem(id: 'all', label: 'All'),
      items: const [
        DropdownItem(id: 'all', label: 'All'),
        DropdownItem(id: 'income', label: 'Income'),
        DropdownItem(id: 'expense', label: 'Expense'),
        DropdownItem(id: 'savings', label: 'Saving'),
      ],
      onChanged: (item) {},
    );
  }
}
