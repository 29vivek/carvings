import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseService {

  static final _databaseName = 'CarvingsDatabase.db';
  static final _databaseVersion = 1;

  static final _favouritesTable = 'Favourites';
  
  DatabaseService._privateConstructor();
  static DatabaseService get instance => DatabaseService._privateConstructor();
  
  static Database _database;
  Future<Database> get database async {
    if(_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // INTEGER, TEXT, REAL in sqlite
    await db.execute('''
      CREATE TABLE $_favouritesTable (
        FoodID INTEGER PRIMARY KEY, 
        Name TEXT,
        Price INTEGER,
        Availability INTEGER,
        Rating REAL,
        NumberRatings INTEGER,
        Category TEXT,
        CanteenName TEXT,
      )
    ''');
  }

}