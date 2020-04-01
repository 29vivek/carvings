import 'package:carvings/locator.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/database_service.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/services/web_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  
  final LocalStorageService _storageService = locator<LocalStorageService>();
  final WebService _webService = locator<WebService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  User _user;
  User get currentUser => _user;

  Future loginWithEmail({@required String email, @required String password}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/login.php',
      formData: {'email': email, 'password': password}
    );
    if(data is String) {
      return data;
    } else if(data['code'] == '0') {
      return data['message'];
    } else {
      _user = User.fromData(data);
      _storageService.user = _user;
      return true;
    }
    
  }

  Future signUpWithEmail({
    @required String email, @required String name,
    @required String number, @required String password,
  }) async {
    
    var data = await _webService.performPostRequest(
      endPoint: '/signup.php',
      formData: {
        'email': email,
        'name': name,
        'number': number,
        'password': password
        }
    );

    if(data is String) {
      return data;
    } else if(data['code'] == '0') {
      return data['message'];
    } else {
      _user = User(id: data['UserID'], email: email, name: name, number: number, role: 'User');
      _storageService.user = _user;
      return true;
    }

  }

  bool hasUserLoggedIn() {
    _user =  _storageService.user;
    return _user != null;
  }

  Future<bool> logout() async {
    _storageService.deleteUser();
    await _databaseService.clearFavourites();
    await _databaseService.clearCart();
    return true;
  }

  Future editUserDetails({
    String email, String name, String number
  }) async {
    var data = await _webService.performPostRequest(
      endPoint: '/editdetails.php',
      formData: {'email': email, 'name': name, 'number': number},
    );
    if(data is String) {
      return data;
    } else if(data['code'] == '0') {
      return data['message'];
    } else {
      _user = User.fromData(data);
      _storageService.user = _user;
      return true;
    }
  }

}