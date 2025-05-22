part of 'note_notifier.dart';

@freezed
abstract class NoteState with _$NoteState {
  const factory NoteState({
    required Resource<List<NoteEntity>> notes,
    required Resource<List<CategoryEntity>> categories,
    @Default(TitleInput.pure()) TitleInput title,
    @Default(ContentInput.pure()) ContentInput content,
    String? selectedCategory,
    bool? isValid,
  }) = _NoteState;

  factory NoteState.initial() => NoteState(
    notes: Resource.initial(),
    categories: Resource.initial(),
    title: TitleInput.pure(),
    content: ContentInput.pure(),
    isValid: true,
  );
}
