part of 'note_notifier.dart';

@freezed
abstract class NoteState with _$NoteState {
  const factory NoteState({
    required Resource<List<NoteEntity>> notes,
    required Resource<List<CategoryEntity>> categories,

    // Result
    required Resource<String> saveResult,
    required Resource<String> updateResult,
    required Resource<String> updateStatusResult,
    required Resource<String> deleteResult,

    @Default(TitleInput.pure()) TitleInput title,
    @Default(ContentInput.pure()) ContentInput content,
    @Default(false) bool isValid,
    String? selectedCategory,
  }) = _NoteState;

  factory NoteState.initial() => NoteState(
    notes: Resource.initial(),
    categories: Resource.initial(),
    saveResult: Resource.initial(),
    updateResult: Resource.initial(),
    updateStatusResult: Resource.initial(),
    deleteResult: Resource.initial(),
  );
}
