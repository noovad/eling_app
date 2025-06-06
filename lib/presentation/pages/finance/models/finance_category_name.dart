import 'package:eling_app/presentation/enum/input_validation_type.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:formz/formz.dart';

class FinanceCategoryNameInput extends FormzInput<String, InputValidation> {
  const FinanceCategoryNameInput.pure() : super.pure('');
  const FinanceCategoryNameInput.dirty({String value = ''})
    : super.dirty(value);

  @override
  InputValidation? validator(String value) {
    if (value.isEmpty) return InputValidation(InputValidationType.empty);
    return null;
  }
}
