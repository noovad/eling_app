import 'package:eling/domain/entities/note/note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_note_request.freezed.dart';
part 'create_note_request.g.dart';

@freezed
abstract class CreateNoteRequest with _$CreateNoteRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CreateNoteRequest({required NoteEntity note}) =
      _CreateNoteRequest;

  factory CreateNoteRequest.fromJson(Map<String, Object?> json) =>
      _$CreateNoteRequestFromJson(json);
}
