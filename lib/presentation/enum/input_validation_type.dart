enum InputValidationType {
  empty,
  minLength;

  String message(String fieldLabel, {dynamic data}) {
    switch (this) {
      case InputValidationType.empty:
        return '$fieldLabel cannot be empty.';
      case InputValidationType.minLength:
        return '$fieldLabel must be at least ${data ?? 'some'} characters.';
    }
  }
}
