import 'package:eling/core/utils/data_type_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
abstract class NoteEntity with _$NoteEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NoteEntity({
    required String id,
    required String title,
    required String content,
    String? category,
    @BoolToIntConverter() @Default(false) bool? isPinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NoteEntity;

  factory NoteEntity.fromJson(Map<String, Object?> json) =>
      _$NoteEntityFromJson(json);
}
