import 'dart:io';

import 'package:eloquent_notes/models/notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
   static DatabaseHelper _databaseHelper;
   static Database _database;

   String tableName = 'notes_table';
   String colId = 'id';
   String colTitle = 'title';
   String colCategory = 'category';
   String colContent = 'content';
   String colDate = 'date';

   DatabaseHelper._createInstance();

   factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initialiseDatabase();
    }
    return _database;
  }

  Future<Database> initialiseDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colContent TEXT, $colCategory TEXT,$colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(tableName, orderBy: '$colDate ASC');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(tableName, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(tableName, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }
  
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableName WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

  Future<List<Note>> getNotesByCategories(String category) async {
       var db = await this.database;   
       var result = await db.query(tableName, where: '$colCategory = ?', whereArgs: [category]);
       var count = result.length;
       List<Note> noteList = List<Note>();
       for (var i = 0; i < count; i++) {
         noteList.add(Note.fromMapObject(result[i]));
       }
       return noteList;
  }

  Future <List<String>> getCategories() async {
    var db = await this.database;
    var result = await db.rawQuery('SELECT DISTINCT	$colCategory FROM $tableName');
    var count = result.length;
    List<String> categoryList = List<String>();
    for (var i = 0; i < count; i++) {
      categoryList.add(fromMapObject(result[i]));
    }
    return categoryList;
  }

}

fromMapObject(Map<String, dynamic> map){
      final name = map['category'];
      return name;
  }