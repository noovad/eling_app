import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';

class TransactionTypeDropdown extends StatelessWidget {
  const TransactionTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDropdown<Object?>(
      showUnselect: false,
      withLabel: false,
      selectedItem: const DropdownItem(id: 'all', label: 'All'),
      items: const [
        DropdownItem(id: 'All', label: 'All'),
        DropdownItem(id: 'Income', label: 'Income'),
        DropdownItem(id: 'Expense', label: 'Expense'),
        DropdownItem(id: 'Savings', label: 'Saving'),
        DropdownItem(id: 'Transfer', label: 'Transfer'),
      ],
      onChanged: (item) {},
    );
  }
}
