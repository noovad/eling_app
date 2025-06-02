import 'package:flutter/material.dart';

class AppFinanceCard extends StatelessWidget {
  final bool leading;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final IconData? icon;

  const AppFinanceCard({
    super.key,
    this.leading = true,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ListTile(
          dense: true,
          leading:
              leading
                  ? Icon(
                    icon ?? Icons.account_balance_wallet,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  )
                  : null,
          title: Text(title, style: Theme.of(context).textTheme.labelMedium),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
