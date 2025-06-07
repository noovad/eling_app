import 'package:eling/domain/entities/transaction/transaction.dart';
import 'package:flutter/material.dart';

class ButtonState extends StatefulWidget {
  final Function(TransactionType) onChanged;
  final TransactionType initialValue;

  const ButtonState({
    super.key,
    required this.onChanged,
    this.initialValue = TransactionType.income,
  });

  @override
  State<ButtonState> createState() => _ButtonStateState();
}

class _ButtonStateState extends State<ButtonState> {
  late TransactionType active;

  final Map<TransactionType, String> _labels = {
    TransactionType.income: 'Income',
    TransactionType.expense: 'Expenses',
    TransactionType.savings: 'Savings',
    TransactionType.transfer: 'Transfer',
  };

  @override
  void initState() {
    super.initState();
    active = widget.initialValue;
  }

  void _onSelect(TransactionType value) {
    setState(() {
      active = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          TransactionType.values.map((type) {
            return Row(
              children: [
                _buildButton(type),
                if (type != TransactionType.values.last)
                  const SizedBox(width: 12),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildButton(TransactionType type) {
    final isActive = active == type;
    final label = _labels[type] ?? type.toString();

    return GestureDetector(
      onTap: () => _onSelect(type),
      child: Card(
        color:
            isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
        elevation: isActive ? 4 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            label,
            style: TextStyle(
              color:
                  isActive
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
