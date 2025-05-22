import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
abstract class NoteEntity with _$NoteEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NoteEntity({
    @Default('') String? id,
    @Default('') String? title,
    @Default('') String? content,
    @Default('') String? category,
    @Default(false) bool? isPinned,
  }) = _NoteEntity;

  factory NoteEntity.fromJson(Map<String, Object?> json) =>
      _$NoteEntityFromJson(json);
}
