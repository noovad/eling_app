import 'package:flutter_ui/desktopPages/todoPage/type.dart';
import 'package:my_app/presentation/pages/note_section/models/content.dart';
import 'package:my_app/presentation/pages/note_section/models/title.dart';

class NoteState {
  final List<Note> notes;
  final TitleInput title;
  final ContentInput content;
  final bool isValid;

  NoteState({
    this.notes = const [],
    this.title = const TitleInput.pure(),
    this.content = const ContentInput.pure(),
    this.isValid = false,
  });

  NoteState copyWith({List<Note>? notes, TitleInput? title, ContentInput? content, bool? isValid}) {
    return NoteState(
      notes: notes ?? this.notes,
      title: title ?? this.title,
      content: content ?? this.content,
      isValid: isValid ?? this.isValid,
    );
  }
}
