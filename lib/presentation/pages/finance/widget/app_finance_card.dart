import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';

class AppFinanceCard extends StatelessWidget {
  final bool leading;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool? highlight;
  final bool trailing;
  final String? trailingText;

  const AppFinanceCard({
    super.key,
    this.leading = true,
    required this.title,
    required this.subtitle,
    this.trailing = false,
    this.highlight,
    this.onTap,
    this.icon,
    this.trailingText,
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
                leading
                    ? Icon(
                      icon ?? Icons.account_balance_wallet,
                      size: 30,
                      color:
                          highlight == true
                              ? Theme.of(context).colorScheme.tertiary
                              : Theme.of(context).colorScheme.primary,
                    )
                    : null,
            title: Text(title, style: Theme.of(context).textTheme.labelMedium),
            subtitle: Row(
              children: [
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color:
                        highlight == true
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
              ],
            ),
            onTap: onTap,
            trailing:
                trailing == true
                    ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      child: Padding(
                        padding: AppPadding.all8,
                        child: Text(
                          trailingText ?? '',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
