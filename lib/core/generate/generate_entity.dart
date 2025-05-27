// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart scripts/generate_entity.dart <entity_name>');
    print('Example: dart scripts/generate_entity.dart note');
    exit(1);
  }

  final entityName = args[0].toLowerCase();
  final entityPascal = toPascalCase(entityName);
  final entityCamel = toCamelCase(entityName);

  // Create directory
  final entityDir = Directory('lib/domain/entities/$entityCamel');
  entityDir.createSync(recursive: true);

  // Generate Entity file
  generateEntity(entityName, entityPascal, entityDir.path);

  print('✅ Generated Entity for $entityPascal');
  print('📁 Location: ${entityDir.path}/$entityName.dart');
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

void generateEntity(String entityName, String entityPascal, String dirPath) {
  final content = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '$entityName.freezed.dart';
part '$entityName.g.dart';

@freezed
abstract class ${entityPascal}Entity with _\$${entityPascal}Entity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ${entityPascal}Entity({
    @Default('') String? id,
    @Default('') String? title,
  }) = _${entityPascal}Entity;

  factory ${entityPascal}Entity.fromJson(Map<String, Object?> json) =>
      _\$${entityPascal}EntityFromJson(json);
}
''';

  final file = File('$dirPath/$entityName.dart');
  file.writeAsStringSync(content.trim());
}