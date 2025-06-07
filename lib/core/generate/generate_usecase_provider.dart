// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) {
  if (args.length < 2) {
    print(
      'Usage: dart lib/core/generate/generate_usecase_provider.dart <entity_name> <usecase_name>',
    );
    print(
      'Example: dart lib/core/generate/generate_usecase_provider.dart category get_categories',
    );
    exit(1);
  }

  final entityName = args[0].toLowerCase();
  final usecaseName = args[1].toLowerCase();
  final usecasePascal = toPascalCase(usecaseName);
  final usecaseCamel = toCamelCase(usecaseName);

  final providerDir = Directory(
    'lib/core/providers/usecase/$entityName/$usecaseCamel',
  );
  providerDir.createSync(recursive: true);

  generateUsecaseProviderFile(
    usecaseName,
    usecasePascal,
    usecaseCamel,
    providerDir.path,
  );

  print('✅ Generated Riverpod Provider for $usecasePascal');
  print('📁 Location: ${providerDir.path}/${usecaseCamel}Provider.dart');
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

void generateUsecaseProviderFile(
  String usecaseName,
  String usecasePascal,
  String usecaseCamel,
  String dirPath,
) {
  final fileName = '${usecaseName}_provider.dart';
  final content = '''
import 'package:eling/core/providers/logger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${usecaseName}_provider.g.dart';

@riverpod
${usecasePascal}UseCase ${usecaseCamel}UseCase(Ref ref) {
  return ${usecasePascal}UseCaseImpl(logger: ref.watch(loggerProvider));
}
''';

  final file = File('$dirPath/$fileName');
  file.writeAsStringSync(content.trim());
}
