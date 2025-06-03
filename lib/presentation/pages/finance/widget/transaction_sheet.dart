import 'package:eling_app/presentation/pages/finance/widget/button_state.dart';
import 'package:eling_app/presentation/pages/finance/widget/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';

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
          TransactionForm(type: type),
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
