import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/sizes/app_padding.dart';

class AppFinanceCard extends StatelessWidget {
  final bool leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool? highlight;
  final bool trailing;
  final String? trailingText;
  final String titleInfo;

  const AppFinanceCard({
    super.key,
    this.leading = true,
    required this.title,
    this.subtitle,
    this.trailing = false,
    this.highlight,
    this.onTap,
    this.icon,
    this.trailingText,
    this.titleInfo = '',
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
                              ? Colors.red[900]
                              : Theme.of(context).colorScheme.primary,
                    )
                    : null,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color:
                          highlight == true
                              ? Colors.red[900]
                              : Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
                Text(titleInfo, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            subtitle: Row(
              children: [
                Text('Rp ', style: Theme.of(context).textTheme.titleLarge),
                Text(
                  subtitle ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
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
