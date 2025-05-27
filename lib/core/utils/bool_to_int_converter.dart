import 'package:freezed_annotation/freezed_annotation.dart';

class BoolToIntConverter implements JsonConverter<bool?, int?> {
  const BoolToIntConverter();

  @override
  bool? fromJson(int? json) {
    if (json == null) return null;
    return json == 1;
  }

  @override
  int? toJson(bool? object) {
    if (object == null) return null;
    return object ? 1 : 0;
  }
}
