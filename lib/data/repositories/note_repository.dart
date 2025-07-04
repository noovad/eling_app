import 'package:eling/data/eling_database.dart';
import 'package:eling/data/model/database_constants.dart';
import 'package:eling/domain/entities/note/note.dart';

class NoteRepository {
  final ElingDatabase _database;

  NoteRepository({ElingDatabase? database})
    : _database = database ?? ElingDatabase.instance;

  Future<NoteEntity> createNote(NoteEntity note) async {
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

  Future<int> countPinnedNotes() async {
    final results = await _database.read(
      TableNames.notes,
      where: 'is_pinned = ?',
      whereArgs: [1],
    );
    return results.length;
  }
}
