import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_note_request.freezed.dart';
part 'delete_note_request.g.dart';

@freezed
abstract class DeleteNoteRequest with _$DeleteNoteRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DeleteNoteRequest({required String id}) =
      _DeleteNoteRequest;

  factory DeleteNoteRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteNoteRequestFromJson(json);
}