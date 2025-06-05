import 'package:eling_app/presentation/enum/input_validation_type.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:formz/formz.dart';

class FinanceTitleInput extends FormzInput<String, InputValidation> {
  const FinanceTitleInput.pure() : super.pure('');
  const FinanceTitleInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InputValidation? validator(String value) {
    if (value.isEmpty) return InputValidation(InputValidationType.empty);
    return null;
  }
}
