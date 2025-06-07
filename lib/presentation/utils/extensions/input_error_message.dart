import 'package:eling/presentation/enum/input_validation_type.dart';

extension InputValidationMessage on InputValidation {
  String get message {
    switch (type) {
      case InputValidationType.empty:
        return 'Field cannot be empty.';
      case InputValidationType.minLength:
        return 'Minimum ${data ?? 'several'} characters.';
    }
  }
}

class InputValidation {
  final InputValidationType type;
  final dynamic data;

  const InputValidation(this.type, [this.data]);
}
