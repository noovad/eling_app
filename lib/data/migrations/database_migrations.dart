import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:eling_app/data/model/database_constants.dart';

class DatabaseMigrations {
  static const int currentVersion = 1;

  static Future<void> onCreate(Database db, int version) async {
    await _createTasksTable(db);
    await _createNotesTable(db);
    await _createCategoriesTable(db);
  }

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 1) {
      await _createTasksTable(db);
      await _createNotesTable(db);
      await _createCategoriesTable(db);
    }
  }

  static Future<void> _createTasksTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const boolType = 'INTEGER';
    const dateTimeType = 'TEXT';

    await db.execute('''
      CREATE TABLE ${TableNames.tasks} (
        ${TaskFields.id} $idType,
        ${TaskFields.title} $textType,
        ${TaskFields.note} $textType,
        ${TaskFields.date} $dateTimeType,
        ${TaskFields.time} $textType,
        ${TaskFields.category} $textType,
        ${TaskFields.isDone} $boolType
      )
    ''');
  }

  static Future<void> _createNotesTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const boolType = 'INTEGER';
    const dateTimeType = 'TEXT';

    await db.execute('''
      CREATE TABLE ${TableNames.notes} (
        ${NoteFields.id} $idType,
        ${NoteFields.title} $textType,
        ${NoteFields.content} $textType,
        ${NoteFields.category} $textType,
        ${NoteFields.createdAt} $dateTimeType,
        ${NoteFields.updatedAt} $dateTimeType,
        ${NoteFields.isPinned} $boolType
      )
    ''');
  }

  static Future<void> _createCategoriesTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';

    await db.execute('''
      CREATE TABLE ${TableNames.categories} (
        ${CategoryFields.id} $idType,
        ${CategoryFields.name} $textType,
        ${CategoryFields.color} $textType,
        ${CategoryFields.icon} $textType,
        ${CategoryFields.type} $textType
      )
    ''');
  }
}
