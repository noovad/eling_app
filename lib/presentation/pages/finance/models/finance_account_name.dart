import 'package:eling/presentation/enum/input_validation_type.dart';
import 'package:eling/presentation/utils/extensions/input_error_message.dart';
import 'package:formz/formz.dart';

class FinanceAccountNameInput extends FormzInput<String, InputValidation> {
  const FinanceAccountNameInput.pure() : super.pure('');
  const FinanceAccountNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InputValidation? validator(String value) {
    if (value.isEmpty) return InputValidation(InputValidationType.empty);
    return null;
  }
}
