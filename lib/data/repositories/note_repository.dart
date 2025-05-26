import 'package:eling_app/data/eling_database.dart';
import 'package:eling_app/data/model/database_constants.dart';
import 'package:eling_app/domain/entities/note/note.dart';

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

  Future<NoteEntity?> readNote(String id) async {
    final results = await _database.read(
      TableNames.notes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return NoteEntity.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<List<NoteEntity>> readAllNotes() async {
    final results = await _database.read(TableNames.notes);
    return results.map((json) => NoteEntity.fromJson(json)).toList();
  }

  Future<int> updateNote(NoteEntity note) async {
    return _database.update(TableNames.notes, note.toJson(), note.id);
  }

  Future<int> deleteNote(String id) async {
    return _database.delete(TableNames.notes, id);
  }
}
