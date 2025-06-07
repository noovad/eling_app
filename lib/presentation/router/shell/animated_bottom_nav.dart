import 'package:eling/presentation/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ui/shared/sizes/app_spaces.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final String currentPath;
  final bool isVisible;

  const AnimatedBottomNavBar({
    super.key,
    required this.currentPath,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: isVisible ? 20 : -80,
      left: 0,
      right: 0,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNavButton(AppPage.todo, context),
            AppSpaces.w16,
            _buildNavButton(AppPage.finance, context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(AppPage page, BuildContext context) {
    final isActive = currentPath == page.route;

    return FloatingActionButton(
      heroTag: page.name,
      onPressed: () => context.go(page.route),
      backgroundColor:
          isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
      elevation: 4,
      tooltip: page.label,
      child: Icon(
        page.icon,
        color:
            isActive
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
