import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:eling_app/data/model/database_constants.dart';

class DatabaseMigrations {
  static const int currentVersion = 2;

  static Future<void> onCreate(Database db, int version) async {
    await _createTasksTable(db);
    await _createRecurringTasksTable(db);
    await _createNotesTable(db);
    await _createCategoriesTable(db);
    await _createTransactionsTable(db);
    await _createAccountsTable(db);
    await _createTransactionCategoriesTable(db);
  }

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 1) {
      await _createTasksTable(db);
      await _createRecurringTasksTable(db);
      await _createNotesTable(db);
      await _createCategoriesTable(db);
    }
    if (oldVersion < 2) {
      await _createTransactionsTable(db);
      await _createAccountsTable(db);
      await _createTransactionCategoriesTable(db);
    }
  }

  static Future<void> _createTasksTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const boolType = 'INTEGER';
    const dateTimeType = 'TEXT';
    const taskType =
        "TEXT CHECK(${TaskFields.type} IN ('daily', 'productivity'))";

    await db.execute('''
      CREATE TABLE ${TableNames.tasks} (
        ${TaskFields.id} $idType,
        ${TaskFields.title} $textType,
        ${TaskFields.note} $textType,
        ${TaskFields.date} $dateTimeType,
        ${TaskFields.time} $textType,
        ${TaskFields.category} $textType,
        ${TaskFields.isDone} $boolType,
        ${TaskFields.type} $taskType,
        ${TaskFields.createdAt} $dateTimeType,
        ${TaskFields.updatedAt} $dateTimeType
      )
    ''');
  }

  static Future<void> _createRecurringTasksTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const dateTimeType = 'TEXT';
    const taskType =
        "TEXT CHECK(${RecurringTaskFields.type} IN ('daily', 'productivity'))";

    await db.execute('''
      CREATE TABLE ${TableNames.recurringTasks} (
        ${RecurringTaskFields.id} $idType,
        ${RecurringTaskFields.title} $textType,
        ${RecurringTaskFields.note} $textType,
        ${RecurringTaskFields.time} $textType,
        ${RecurringTaskFields.category} $textType,
        ${RecurringTaskFields.type} $taskType,
        ${RecurringTaskFields.createdAt} $dateTimeType,
        ${RecurringTaskFields.updatedAt} $dateTimeType
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
        ${CategoryFields.type} $textType
      )
    ''');
  }

  static Future<void> _createTransactionsTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const dateTimeType = 'TEXT';
    const doubleType = 'REAL';
    const transactionType =
        "TEXT CHECK(type IN ('income', 'expense', 'savings', 'transfer'))";

    await db.execute('''
      CREATE TABLE transactions (
        id $idType,
        type $transactionType,
        title $textType,
        date $dateTimeType,
        amount $doubleType,
        category $textType,
        source $textType,
        target $textType,
        description $textType
      )
    ''');
  }

  static Future<void> _createAccountsTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const accountType = "TEXT CHECK(type IN ('balance', 'saving'))";

    await db.execute('''
      CREATE TABLE accounts (
        id $idType,
        type $accountType,
        title $textType
      )
    ''');
  }

  static Future<void> _createTransactionCategoriesTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';

    await db.execute('''
      CREATE TABLE ${TableNames.transactionCategories} (
        ${TransactionCategoryFields.id} $idType,
        ${TransactionCategoryFields.name} $textType
      )
    ''');
  }
}
