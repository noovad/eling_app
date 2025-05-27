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

class DateOnlyConverter implements JsonConverter<DateTime, String> {
  const DateOnlyConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return '${object.year.toString().padLeft(4, '0')}-'
        '${object.month.toString().padLeft(2, '0')}-'
        '${object.day.toString().padLeft(2, '0')}';
  }
}
