import 'package:flutter/material.dart';
import 'package:my_app/presentation/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'My App',
      debugShowCheckedModeBanner: false,
    );
  }
}
