import 'package:eling/presentation/enum/input_validation_type.dart';
import 'package:eling/presentation/utils/extensions/input_error_message.dart';
import 'package:formz/formz.dart';

class FinanceSourceInput extends FormzInput<String, InputValidation> {
  const FinanceSourceInput.pure() : super.pure('');
  const FinanceSourceInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InputValidation? validator(String value) {
    if (value.isEmpty) return InputValidation(InputValidationType.empty);
    return null;
  }
}
