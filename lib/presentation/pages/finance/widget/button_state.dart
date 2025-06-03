import 'package:flutter/material.dart';

class ButtonState extends StatefulWidget {
  final Function(String selectedCategory) onChanged;
  final String initialValue;

  const ButtonState({
    super.key,
    required this.onChanged,
    this.initialValue = 'Income',
  });

  @override
  State<ButtonState> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<ButtonState> {
  late String active;

  @override
  void initState() {
    super.initState();
    active = widget.initialValue;
  }

  void _onSelect(String value) {
    setState(() {
      active = value;
    });
    widget.onChanged(value); // Notify parent
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildButton('Income'),
        const SizedBox(width: 12),
        _buildButton('Expenses'),
        const SizedBox(width: 12),
        _buildButton('Savings'),
        const SizedBox(width: 12),
        _buildButton('Transfer'),
      ],
    );
  }

  Widget _buildButton(String label) {
    final isActive = active == label;

    return GestureDetector(
      onTap: () => _onSelect(label),
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
