import 'package:eling/domain/entities/note/note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_note_request.freezed.dart';
part 'update_note_request.g.dart';

@freezed
abstract class UpdateNoteRequest with _$UpdateNoteRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateNoteRequest({required NoteEntity note}) =
      _UpdateNoteRequest;

  factory UpdateNoteRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateNoteRequestFromJson(json);
}
