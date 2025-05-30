import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/data/model/database_constants.dart';
import 'package:eling_app/domain/entities/note/note.dart';

class NoteRepository {
  final ElingDatabase _database;

  NoteRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<NoteEntity> createNote(NoteEntity note) async {
    print(note);
    return _database.create<NoteEntity>(
      TableNames.notes,
      note,
      (note) => note.toJson(),
    );
  }

  Future<List<NoteEntity>> readAllNotes() async {
    final results = await _database.read(
      TableNames.notes,
      orderBy: 'is_pinned DESC, created_at DESC',
    );
    return results.map((json) => NoteEntity.fromJson(json)).toList();
  }

  Future<int> updateNote(NoteEntity note) async {
    return _database.update(TableNames.notes, note.toJson(), note.id);
  }

  Future<int> updatePinned(String id, bool isPinned) async {
    return _database.update(TableNames.notes, {
      'is_pinned': !isPinned ? 1 : 0,
    }, id);
  }

  Future<int> deleteNote(String id) async {
    return _database.delete(TableNames.notes, id);
  }
}
