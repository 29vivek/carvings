import 'dart:io';

import 'package:carvings/models/food.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseService {

  static final _databaseName = 'CarvingsDatabase.db';
  static final _databaseVersion = 1;

  static final _favouritesTable = 'Favourites';
  final _maximumFavouries = 8;
  
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
        CanteenName TEXT
      )
    ''');
  }

  Future<dynamic> insertFavourite(Food food) async {
    Database db = await instance.database;
    bool present = await _isFavouritePresent(food.id);
    if(present) {
      return 'This item is already present in your favourites.';
    }
    int number = await _numberOfFavourites();
    if(number == _maximumFavouries) {
      return 'Maximum limit reached.';
    }
    return await db.insert(_favouritesTable, food.toJson());
  }

  Future<List<Food>> getFavourites() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(_favouritesTable);
    return result.map((item) => Food.fromData(item)).toList();
  }

  Future<int> _numberOfFavourites() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $_favouritesTable'));
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_favouritesTable, where: 'FoodID = ?', whereArgs: [id]);
  }

  Future<bool> _isFavouritePresent(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(_favouritesTable, where: 'FoodID = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }

  Future<List<dynamic>> getFavouriteIds() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(_favouritesTable, columns: ['FoodID']);
    return result.map((item) => item['FoodID']).toList();
  }

  Future<void> updateAvailabilities(List<dynamic> ids, List<dynamic> availabilities) async {
    Database db = await instance.database;
    // old school for loop, cause why not
    for(var i=0; i<ids.length; i++) {
      await db.update(_favouritesTable, {'Availability': availabilities[i]}, where: 'FoodID = ?', whereArgs: [ids[i]]);
    }
  }

}