import 'package:formz/formz.dart';

enum TitleInputError { empty }

class TitleInput extends FormzInput<String, TitleInputError> {
  const TitleInput.pure() : super.pure('');
  const TitleInput.dirty({String value = ''}) : super.dirty(value);

  @override
  TitleInputError? validator(String value) {
    return value.isEmpty ? TitleInputError.empty : null;
  }
}

extension TitleInputErrorMessage on TitleInputError {
  String getMessage() {
    switch (this) {
      case TitleInputError.empty:
        return 'Title cannot be empty.';
    }
  }
}
