import 'package:eling/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/shared/themes/app_theme_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        theme: AppTheme.lightTheme(),
        routerConfig: AppRouter.router,
        title: 'Éling App',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
