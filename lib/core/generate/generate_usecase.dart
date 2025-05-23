// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> args) {
  if (args.length < 2) {
    print('Usage: dart scripts/generate_usecase.dart <entity> <operation>');
    print('Example: dart scripts/generate_usecase.dart category get_categories');
    exit(1);
  }

  final entity = args[0];
  final operation = args[1];
  final returnType = 'bool';

  // Convert to PascalCase
  final operationPascal = toPascalCase(operation);
  
  // Create directories
  final usecaseDir = Directory('lib/domain/usecases/$entity/$operation');
  usecaseDir.createSync(recursive: true);

  // Generate UseCase file
  generateUseCase(entity, operation, operationPascal, returnType, usecaseDir.path);
  
  // Generate Request file
  generateRequest(operation, operationPascal, usecaseDir.path);

  print('✅ Generated UseCase and Request for $operationPascal');
  print('📁 Location: ${usecaseDir.path}');
}

String toPascalCase(String input) {
  return input
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join('');
}

void generateUseCase(String entity, String operation, String operationPascal, String returnType, String dirPath) {
  final content = '''
import 'package:eling_app/core/utils/result.dart';
import 'package:eling_app/domain/usecases/base_usecase.dart';
import 'package:eling_app/domain/usecases/$entity/$operation/${operation}_request.dart';

abstract class ${operationPascal}UseCase {
  Future<Result<bool>> execute(${operationPascal}Request request);
}

class ${operationPascal}UseCaseImpl
    extends BaseUsecase<${operationPascal}Request, bool>
    implements ${operationPascal}UseCase {
  @override
  String get usecaseName => '${operationPascal}UseCase';

  ${operationPascal}UseCaseImpl({required super.logger});

  @override
  Future<Result<bool>> execute(
    ${operationPascal}Request request,
  ) async {
    return safeExecute(request, () async {
      // TODO: Implement your logic here
      return true;
    });
  }
}
''';

  final file = File('$dirPath/${operation}_usecase.dart');
  file.writeAsStringSync(content.trim());
}

void generateRequest(String operation, String operationPascal, String dirPath) {
  final content = '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${operation}_request.freezed.dart';
part '${operation}_request.g.dart';

@freezed
abstract class ${operationPascal}Request with _\$${operationPascal}Request {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ${operationPascal}Request({required String id}) =
      _${operationPascal}Request;

  factory ${operationPascal}Request.fromJson(Map<String, Object?> json) =>
      _\$${operationPascal}RequestFromJson(json);
}
''';

  final file = File('$dirPath/${operation}_request.dart');
  file.writeAsStringSync(content.trim());
}