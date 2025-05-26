import 'package:eling_app/presentation/enum/input_validation_type.dart';
import 'package:eling_app/presentation/utils/extensions/input_error_message.dart';
import 'package:formz/formz.dart';

class ContentInput extends FormzInput<String, InputValidation> {
  const ContentInput.pure() : super.pure('');
  const ContentInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InputValidation? validator(String value) {
    if (value.isEmpty) return InputValidation(InputValidationType.empty);
    if (value.length < 10) {
      return InputValidation(InputValidationType.minLength, 10);
    }
    return null;
  }
}
