import 'dart:convert';
import 'package:carvings/constants/addresses.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  
  Dio dio = Dio();
  final LocalStorageService _storageService = locator<LocalStorageService>();

  Future loginWithEmail({@required String email, @required String password}) async {
    
    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'password': password
        });
      Response response = await dio.post(
          '$OtherWiFi/login.php',
          data: formData,
          options: Options(
            method: 'POST',
            responseType: ResponseType.json
          )
      ).timeout(Duration(seconds: 10));

      print(response.statusCode);
      var data = jsonDecode(response.data);
      print(data['UserID']);
      if(data['code'] == '0') {
        // error has occured so return message.
        return data['message'];
      } else {
        // print(data['UserID']);
        _storageService.user = User.fromData(data);
        return true;
      }
    } catch(e) {
        return e.message;
    }
    
    
  }

  Future signUpWithEmail({
    @required String email, @required String name,
    @required String number, @required String password,
  }) async {
    
    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'name': name,
        'number': number,
        'password': password
        });
      Response response = await dio.post(
          '$OtherWiFi/signup.php',
          data: formData,
          options: Options(
            method: 'POST',
            responseType: ResponseType.json
          )
      ).timeout(Duration(seconds: 10));

      print(response.statusCode);
      var data = jsonDecode(response.data);

      if(data['code'] == '0') {
        // error has occured so return message.
        return data['message'];
      } else {
        _storageService.user = User(id: data['UserID'], email: email, name: name, number: number, role: 'User');
        return true;
      }
    } catch(e) {
        return e.message;
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