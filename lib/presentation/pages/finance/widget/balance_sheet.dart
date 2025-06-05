import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';
import 'package:flutter_ui/shared/sizes/app_sizes.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';
import 'package:flutter_ui/widgets/appField/app_text_field.dart';

class BalanceSheet extends StatelessWidget {
  const BalanceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BalanceItem> balances = [
      BalanceItem(id: '1', name: 'Bank BCA', amount: 5000000),
      BalanceItem(id: '2', name: 'Cash', amount: 1500000),
      BalanceItem(id: '3', name: 'E-Wallet', amount: 750000),
      BalanceItem(id: '4', name: 'Credit Card', amount: -2000000),
    ];
    return Padding(
      padding: AppPadding.h16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSpaces.h40,
          AppTextField(
            label: "Account Name",
            hint: "Enter account name",
            isRequired: true,
          ),
          AppSpaces.h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              AppSpaces.w8,
              ElevatedButton(onPressed: null, child: const Text('Create')),
            ],
          ),
          AppSpaces.h16,
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                itemCount: balances.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final balance = balances[index];

                  return Card(
                    margin: EdgeInsets.only(top: AppSizes.dimen16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.outline,
                    child: ListTile(
                      title: Text(balance.name),
                      subtitle: Text(
                        'Rp 1000.000',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => {},
                        // show if balance is 0
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Simple data class for balance items
class BalanceItem {
  final String id;
  final String name;
  final double amount;

  BalanceItem({required this.id, required this.name, required this.amount});
}
