import 'package:flutter_db/model/note.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DbHelper {
  static Future<void> createTable(sql.Database database) async {
    database.execute(
      """
        CREATE TABLE notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          title TEXT NOT NULL,
          desc TEXT NOT NULL,
          date TEXT NOT NULL,
          type TEXT NOT NULL
        )
      """
    );
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "notes.db",
      version: 2,
      onCreate: (sql.Database db, int version) async {
        return createTable(db);
      }
    );
  }
  static Future<void> saveNote(Note note) async {
    final db = await DbHelper.db();
    await db.insert('notes', note.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  static Future<List<Note>> getNotes() async {
    final db = await DbHelper.db();
    final map = await db.query('notes',orderBy: 'id');
    return map.map((e) => Note.fromJson(e)).toList();
  }
  static Future<void> deleteNote(int? id) async {
    final db = await DbHelper.db();
    await db.delete("notes",where: "id = ?", whereArgs: ["$id"]);
  }
  static Future<void> updateNote(int? id, Note? note) async {
    final db = await DbHelper.db();
    await db.update('notes', note?.toJson() ?? {}, where: "id = ?", whereArgs: ["$id"]);
  }
}
