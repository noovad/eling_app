import 'package:eling/presentation/router/shell/animated_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  final GoRouterState state;

  const AppShell({super.key, required this.child, required this.state});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _isNavBarVisible = false;
  static const double triggerDistanceFromBottom = 100;

  void _checkCursorPosition(PointerEvent event) {
    final size = MediaQuery.of(context).size;
    final cursorY = event.position.dy;
    final shouldShow = (size.height - cursorY) <= triggerDistanceFromBottom;

    if (shouldShow != _isNavBarVisible) {
      setState(() {
        _isNavBarVisible = shouldShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = widget.state.uri.toString();

    return Scaffold(
      body: MouseRegion(
        onHover: _checkCursorPosition,
        child: Stack(
          children: [
            widget.child,
            AnimatedBottomNavBar(
              currentPath: currentPath,
              isVisible: _isNavBarVisible,
            ),
          ],
        ),
      ),
    );
  }
}
