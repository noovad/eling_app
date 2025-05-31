import 'package:eling_app/app.dart';
import 'package:eling_app/data/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final TaskRepository taskRepository = TaskRepository();

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    const Size minAppSize = Size(1280, 720);
    const WindowOptions options = WindowOptions(
      minimumSize: minAppSize,
      center: true,
      backgroundColor: Colors.transparent,
    );

    windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.maximize();
      await windowManager.setMinimumSize(minAppSize);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  await taskRepository.generateTodayTasksFromRecurringOncePerDay();

  runApp(const ProviderScope(child: MyApp()));
}
