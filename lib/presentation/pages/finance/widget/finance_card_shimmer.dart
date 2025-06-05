import 'package:flutter/material.dart';
import 'package:flutter_ui/widgets/appShimmer/app_shimmer.dart';

class FinanceCardShimmer extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isLeading;

  const FinanceCardShimmer({
    super.key,
    required this.title,
    this.icon,
    this.isLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 70,
        child: Card(
          child: ListTile(
            dense: true,
            leading:
                isLeading
                    ? Icon(
                      icon ?? Icons.account_balance_wallet,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    )
                    : null,
            title: Text(title, style: Theme.of(context).textTheme.labelMedium),
            subtitle: AppShimmer(height: 26, width: 120),
          ),
        ),
      ),
    );
  }
}
