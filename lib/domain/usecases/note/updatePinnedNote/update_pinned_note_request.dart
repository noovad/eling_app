import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_pinned_note_request.freezed.dart';
part 'update_pinned_note_request.g.dart';

@freezed
abstract class UpdatePinnedNoteRequest with _$UpdatePinnedNoteRequest {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdatePinnedNoteRequest({required String id, required bool isPinned}) =
      _UpdatePinnedNoteRequest;

  factory UpdatePinnedNoteRequest.fromJson(Map<String, Object?> json) =>
      _$UpdatePinnedNoteRequestFromJson(json);
}