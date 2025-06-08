import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:eling/data/migrations/database_migrations.dart';
import 'package:path_provider/path_provider.dart';

class ElingDatabase {
  static final ElingDatabase instance = ElingDatabase._init();
  static Database? _database;

  ElingDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('eling.db');
    return _database!;
  }

  Future<String> getAppDataPath() async {
    final directory = await getApplicationSupportDirectory();
    final path = directory.path;
    await Directory(path).create(recursive: true);
    return path;
  }

  Future<Database> _initDB(String filePath) async {
    final appDataPath = await getAppDataPath();
    final path = '$appDataPath/$filePath';

    // final basePath = Directory.current.path;
    // final path = '$basePath/$filePath';
    
    return await openDatabase(
      path,
      version: DatabaseMigrations.currentVersion,
      onCreate: DatabaseMigrations.onCreate,
      onUpgrade: DatabaseMigrations.onUpgrade,
    );
  }

  // Generic CRUD operations
  Future<T> create<T>(
    String table,
    T entity,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    final db = await instance.database;
    await db.insert(table, toJson(entity));
    return entity;
  }

  Future<List<Map<String, dynamic>>> read(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await instance.database;
    return db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  Future<int> update(String table, Map<String, dynamic> data, String id) async {
    final db = await instance.database;
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, String id) async {
    final db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
