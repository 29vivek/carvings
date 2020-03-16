import 'dart:convert';

import 'package:carvings/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static const userKey = 'user';

  static Future<LocalStorageService> getInstance() async {
    if(_instance == null) {
      _instance = LocalStorageService();
    }
    if(_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  User get user {
    var userJson = _getFromDisk(userKey);
    if(userJson == null) 
      return null;
    
    return User.fromData(json.decode(userJson));
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  set user(User userToSave) {
    _saveStringToDisk(userKey, json.encode(userToSave.toJson()));
  }

  void _saveStringToDisk(String key, String content) {
    _preferences.setString(key, content);
  }

  void deleteUser() {
    _clearStringFromDisk(userKey);
  }

  void _clearStringFromDisk(String key) {
    _preferences.remove(key);
  }

}
