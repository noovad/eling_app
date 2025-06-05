import 'package:eling_app/domain/entities/transaction/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appDropdown/app_dropdown.dart';

class TransactionTypeDropdown extends StatelessWidget {
  final ValueChanged<TransactionType?>? onChanged;

  const TransactionTypeDropdown({super.key, this.onChanged});

  static const List<DropdownItem<TransactionType?>> _items = [
    DropdownItem(id: null, label: 'All'),
    DropdownItem(id: TransactionType.income, label: 'Income'),
    DropdownItem(id: TransactionType.expense, label: 'Expense'),
    DropdownItem(id: TransactionType.savings, label: 'Saving'),
    DropdownItem(id: TransactionType.transfer, label: 'Transfer'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppDropdown<TransactionType?>(
      showUnselect: false,
      withLabel: false,
      selectedItem: _items.firstWhere(
        (item) => item.id == null,
        orElse: () => _items[0],
      ),
      items: _items,
      onChanged:
          (DropdownItem<TransactionType?>? item) => onChanged?.call(item?.id),
    );
  }
}
