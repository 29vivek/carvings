import 'package:carvings/locator.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/services/web_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  
  final LocalStorageService _storageService = locator<LocalStorageService>();
  final WebService _webService = locator<WebService>();

  User _currentUser;
  User get currentUser => _currentUser;

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
      _currentUser = User.fromData(data);
      _storageService.user = _currentUser;
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
      _currentUser = User(id: data['UserID'], email: email, name: name, number: number, role: 'User');
      _storageService.user = _currentUser;
      return true;
    }

  }

  bool hasUserLoggedIn() {
    _currentUser =  _storageService.user;
    return _currentUser != null;
  }

  bool logout() {
    _storageService.deleteUser();
    _currentUser = null;
    return true;
  }

}