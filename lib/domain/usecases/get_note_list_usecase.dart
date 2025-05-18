import 'package:flutter_ui/desktopPages/todoPage/type.dart';

class NoteRepository {
  Future<List<Note>> fetchNotes() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Note(id: '1', title: 'First Note', content: 'Lorem ipsum'),
      Note(id: '2', title: 'Second Note', content: 'Dolor sit amet'),
    ];
  }
}
