// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print(
      'Usage: dart lib/core/generate/generate_notifier_provider.dart <notifier_name>',
    );
    print(
      'Example: dart lib/core/generate/generate_notifier_provider.dart task',
    );
    exit(1);
  }

  final notifierName = args[0].toLowerCase();
  final notifierPascal = toPascalCase(notifierName);

  final providerDir = Directory('lib/core/providers/notifier');
  providerDir.createSync(recursive: true);

  generateNotifierProviderFile(notifierName, notifierPascal, providerDir.path);

  print('✅ Generated Notifier Provider for $notifierPascal');
  print(
    '📁 Location: ${providerDir.path}/${notifierName}_notifier_provider.dart',
  );
  print('Run this command to generate the code:');
  print('flutter pub run build_runner build --delete-conflicting-outputs');
}

String toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join('');
}

String toCamelCase(String input) {
  final parts = input.split('_');
  if (parts.isEmpty) return '';
  return parts.first.toLowerCase() +
      parts
          .skip(1)
          .map(
            (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
          )
          .join('');
}

void generateNotifierProviderFile(
  String notifierName,
  String notifierPascal,
  String dirPath,
) {
  final fileName = '${notifierName}_notifier_provider.dart';
  final content = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ${notifierName}NotifierProvider = StateNotifierProvider<${notifierPascal}Notifier, ${notifierPascal}State>((ref) {
  return ${notifierPascal}Notifier();
});
''';

  final file = File('$dirPath/$fileName');
  file.writeAsStringSync(content.trim());
}
