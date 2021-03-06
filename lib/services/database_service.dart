import 'dart:io';

import 'package:carvings/models/cart_item.dart';
import 'package:carvings/models/food.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseService {

  static final _databaseName = 'CarvingsDatabase.db';
  static final _databaseVersion = 1;

  static final _favouritesTable = 'Favourites';
  static final _maximumFavouries = 8;

  static final _cartTable = 'Cart';
  
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
        CategoryName TEXT,
        CanteenName TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $_cartTable (
        FoodID INTEGER PRIMARY KEY,
        Name TEXT,
        Price INTEGER,        
        Quantity INTEGER,
        CanteenName TEXT
      )
    ''');

  }

  Future<dynamic> insertToCart(CartItem item) async {
    
    Database db = await instance.database;
    List<Map<String, dynamic>> presentItemCount = await db.query(_cartTable, columns: ['Quantity'], where: 'FoodID = ?', whereArgs: [item.foodId], limit: 1);

    if(presentItemCount.isNotEmpty) {
      return updateCartItemQuantity(item.foodId, presentItemCount.first['Quantity'] + item.quantity);
    }

    return await db.insert(_cartTable, item.toJson());
  }

  Future<List<CartItem>> getCartItems() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(_cartTable);
    return result.map((item) => CartItem.fromData(item)).toList();
  }

  Future<void> clearCart() async {
    Database db = await instance.database;
    await db.delete(_cartTable);
  }

  Future<void> updateCartItemQuantity(int id, int newQuantity) async {
    Database db = await instance.database;
    return await db.update(_cartTable, {'Quantity' : newQuantity}, where: 'FoodID = ?', whereArgs: [id]);
  }

  Future<int> deleteCartItem(int id) async {
    Database db = await instance.database;
    return await db.delete(_cartTable, where: 'FoodID = ?', whereArgs: [id]);
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

  Future<int> deleteFavourite(int id) async {
    Database db = await instance.database;
    return await db.delete(_favouritesTable, where: 'FoodID = ?', whereArgs: [id]);
  }

  Future<void> clearFavourites() async {
    Database db = await instance.database;
    await db.delete(_favouritesTable);
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
      await db.update(_favouritesTable, availabilities[i], where: 'FoodID = ?', whereArgs: [ids[i]]);
    }
  }

  Future<void> updateAllFood(List<dynamic> fetchedFood) async {
    Database db = await instance.database;
    await db.delete(_favouritesTable);
    Batch batch = db.batch();
    for(var food in fetchedFood) {
      batch.insert(_favouritesTable, food);
    }
    await batch.commit(noResult: true);
  }



}