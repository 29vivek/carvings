import 'package:carvings/locator.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/services/web_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  
  Dio dio = Dio();
  final LocalStorageService _storageService = locator<LocalStorageService>();
  final WebService _webService = locator<WebService>();


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
      _storageService.user = User.fromData(data);
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
      _storageService.user = User(id: data['UserID'], email: email, name: name, number: number, role: 'User');
      return true;
    }

  }

  bool hasUserLoggedIn() {
    var user =  _storageService.user;
    return user != null;
  }

  bool logout() {
    _storageService.deleteUser();
    return true;
  }

}