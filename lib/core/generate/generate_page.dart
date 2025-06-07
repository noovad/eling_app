// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart lib/core/generate/generate_page.dart <page_name>');
    print('Example: dart lib/core/generate/generate_page.dart note');
    exit(1);
  }

  final pageName = args[0].toLowerCase();
  final pagePascal = toPascalCase(pageName);

  // Create directories
  final pageDir = Directory('lib/presentation/pages/$pageName');
  pageDir.createSync(recursive: true);

  final modelsDir = Directory('${pageDir.path}/models');
  modelsDir.createSync(recursive: true);

  final widgetDir = Directory('${pageDir.path}/widget');
  widgetDir.createSync(recursive: true);

  final notifierDir = Directory('${pageDir.path}/notifier');
  notifierDir.createSync(recursive: true);

  // Generate files
  generatePage(pageName, pagePascal, pageDir.path);
  generateState(pageName, pagePascal, notifierDir.path);
  generateNotifier(pageName, pagePascal, notifierDir.path);

  print('✅ Generated Page for $pagePascal');
  print('📁 Location: ${pageDir.path}');
  print('📄 Files created:');
  print('   - ${pageName}_page.dart');
  print('   - notifier/${pageName}_state.dart');
  print('   - notifier/${pageName}_notifier.dart');
  print('   - models/ (empty)');
  print('   - widget/ (empty)');
}

String toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join('');
}

void generatePage(String pageName, String pagePascal, String dirPath) {
  final content = '''
import 'package:flutter/material.dart';

class ${pagePascal}Page extends StatelessWidget {
  const ${pagePascal}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$pagePascal'),
      ),
      body: const Center(
        child: Text('$pagePascal Page'),
      ),
    );
  }
}
''';

  final file = File('$dirPath/${pageName}_page.dart');
  file.writeAsStringSync(content.trim());
}

void generateState(String pageName, String pagePascal, String dirPath) {
  final content = '''
part of '${pageName}_notifier.dart';

@freezed
abstract class ${pagePascal}State with _\$${pagePascal}State {
  const factory ${pagePascal}State({
    required Resource<String> title,
    @Default('') String name,
  }) = _${pagePascal}State;

  factory ${pagePascal}State.initial() => ${pagePascal}State(
    title: Resource.initial(),
  );
}
''';

  final file = File('$dirPath/${pageName}_state.dart');
  file.writeAsStringSync(content.trim());
}

void generateNotifier(String pageName, String pagePascal, String dirPath) {
  final content = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eling/core/utils/resource.dart';

part '${pageName}_state.dart';
part '${pageName}_notifier.freezed.dart';

class ${pagePascal}Notifier extends StateNotifier<${pagePascal}State> {
  ${pagePascal}Notifier() : super(${pagePascal}State.initial());

  // Add your methods here
}
''';

  final file = File('$dirPath/${pageName}_notifier.dart');
  file.writeAsStringSync(content.trim());
}
