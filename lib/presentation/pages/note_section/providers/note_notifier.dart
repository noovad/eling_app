import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/desktopPages/todoPage/type.dart';
import 'package:formz/formz.dart';
import 'package:my_app/presentation/pages/note_section/models/content.dart';
import 'package:my_app/presentation/pages/note_section/models/title.dart';
import 'package:my_app/presentation/pages/note_section/providers/note_state.dart';

class NoteNotifier extends StateNotifier<NoteState> {
  NoteNotifier() : super(NoteState());

  void fetchNotes() {
    final fetchedNotes = [
      Note(id: '1', title: 'Sample Note 1', content: 'This is the content of note 1.', isPinned: false),
      Note(id: '2', title: 'Sample Note 2', content: 'This is the content of note 2.', isPinned: true),
    ];
    state = state.copyWith(notes: fetchedNotes);
  }

  void titleChanged(String value) {
    final title = TitleInput.dirty(value: value);
    final isValid = Formz.validate([title, state.content]);
    state = state.copyWith(title: title, isValid: isValid);
  }

  void contentChanged(String value) {
    final content = ContentInput.dirty(value: value);
    final isValid = Formz.validate([state.title, content]);
    state = state.copyWith(content: content, isValid: isValid);
  }

  void addNote() {
    final title = TitleInput.dirty();
    final content = ContentInput.dirty();
    final isValid = Formz.validate([title, content]);

    if (!isValid) {
      state = state.copyWith(title: title, content: content, isValid: false);
      return;
    }

    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.value,
      content: content.value,
      isPinned: false,
    );

    state = state.copyWith(
      notes: [...state.notes, newNote],
      title: const TitleInput.pure(),
      content: const ContentInput.pure(),
      isValid: false,
    );
  }

  void updateNote(Note updatedNote) {
    final updatedNotes =
        state.notes.map((note) {
          return note.id == updatedNote.id ? updatedNote : note;
        }).toList();
    state = NoteState(notes: updatedNotes);
  }

  void togglePin(String id) {
    final updatedNotes =
        state.notes.map((note) {
          if (note.id == id) {
            return note.copyWith(isPinned: !note.isPinned);
          }
          return note;
        }).toList();
    state = NoteState(notes: updatedNotes);
  }

  void deleteNote(String id) {
    final updatedNotes = state.notes.where((note) => note.id != id).toList();
    state = NoteState(notes: updatedNotes);
  }
}
