part of 'note_notifier.dart';

@freezed
abstract class NoteState with _$NoteState {
  const factory NoteState({
    @Default(Resource.initial()) Resource<List<NoteEntity>> notes,
    @Default(Resource.initial()) Resource<List<CategoryEntity>> categories,
    @Default(Resource.initial()) Resource<int> countPinnedNotes,

    // Result
    @Default(Resource.initial()) Resource<String> saveResult,
    @Default(Resource.initial()) Resource<String> updateResult,
    @Default(Resource.initial()) Resource<String> updateStatusResult,
    @Default(Resource.initial()) Resource<String> deleteResult,

    @Default(TitleInput.pure()) TitleInput title,
    @Default(ContentInput.pure()) ContentInput content,
    @Default(false) bool isValid,
    String? selectedCategory,
  }) = _NoteState;

  factory NoteState.initial() => NoteState();
}
