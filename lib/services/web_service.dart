import 'dart:convert';
import 'package:carvings/constants/addresses.dart';
import 'package:dio/dio.dart';

class WebService {

  static Dio _dio;
  static WebService _instance;

  static WebService getInstance() {
    if(_instance == null) {
      _instance = WebService();
    }
    if(_dio == null) {
      _dio = Dio();
      _dio.options.baseUrl = 'http://$Emulator/carvings';
      _dio.options.responseType = ResponseType.json;
    }
    return _instance;
  }

  Future performPostRequest({String endPoint, Map<String, dynamic> formData}) async {
    try {
      Response response = await _dio.post(endPoint, data: FormData.fromMap(formData)).timeout(Duration(seconds: 5));
      if(response.statusCode == 200) {
        return jsonDecode(response.data);
      }
      else {
        return response.statusMessage;
      }
    } catch(e) {
      print('Exception occured: ${e.message}');
      return e.message;
    }
  } 

  Future performGetRequest({String endPoint}) async {
    try {
      Response response = await _dio.get(endPoint).timeout(Duration(seconds: 5));
      if(response.statusCode == 200) {
        return jsonDecode(response.data);
      }
      else {
        return response.statusMessage;
      }
    } catch(e) {
      print('Exception occured: ${e.message}');
      return e.message;
    }
  }
  

}