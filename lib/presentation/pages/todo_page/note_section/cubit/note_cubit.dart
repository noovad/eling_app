import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui/desktopPages/todoPage/type.dart';
import 'package:my_app/domain/usecases/get_note_list_usecase.dart';
import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final NoteRepository repository;

  NoteCubit(this.repository) : super(NoteState.initial());

  Future<void> loadNotes() async {
    emit(state.copyWith(loading: true));
    final notes = await repository.fetchNotes();
    emit(state.copyWith(loading: false, notes: notes));
  }

  void addNote(Note note) {
    final updated = List<Note>.from(state.notes)..add(note);
    emit(state.copyWith(notes: updated));
  }

  void deleteNote(Note note) {
    final updated = List<Note>.from(state.notes)
      ..removeWhere((n) => n.id == note.id);
    emit(state.copyWith(notes: updated));
  }

  void updateNote(Note updatedNote) {
    final updated =
        state.notes
            .map((n) => n.id == updatedNote.id ? updatedNote : n)
            .toList();
    emit(state.copyWith(notes: updated));
  }
}
