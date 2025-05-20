import 'package:formz/formz.dart';

enum ContentInputError { empty, minLength }

class ContentInput extends FormzInput<String, ContentInputError> {
  const ContentInput.pure() : super.pure('');
  const ContentInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ContentInputError? validator(String value) {
    if (value.isEmpty) {
      return ContentInputError.empty;
    }
    if (value.length < 10) {
      return ContentInputError.minLength;
    } else {
      return null;
    }
  }
}

extension ContentInputErrorMessage on ContentInputError {
  String getMessage() {
    switch (this) {
      case ContentInputError.empty:
        return 'Content cannot be empty.';
      case ContentInputError.minLength:
        return 'Content must be at least 10 characters long.';
    }
  }
}
