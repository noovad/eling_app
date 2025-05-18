import 'package:flutter_ui/desktopPages/todoPage/type.dart';

class NoteState {
  final List<Note> notes;
  final bool loading;

  NoteState({required this.notes, required this.loading});

  factory NoteState.initial() => NoteState(notes: [], loading: false);

  NoteState copyWith({List<Note>? notes, bool? loading}) {
    return NoteState(
      notes: notes ?? this.notes,
      loading: loading ?? this.loading,
    );
  }
}
