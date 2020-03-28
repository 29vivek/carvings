import 'package:carvings/locator.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/services/web_service.dart';
import 'package:flutter/foundation.dart';

class FoodService {
  
  final WebService _webService = locator<WebService>();

  List<Canteen> _canteens;
  List<Canteen> get canteens => _canteens;

  Future getFoodItemsFor({@required int canteenId, bool categorized = false}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/getfood.php',
      formData: {'canteenId': canteenId},
    );
    if(data is String) {
      return data;
    } else {
      if(categorized) {
        var categorizedFood = Map<String, List<Food>>();
        for(var category in data['categories']) {
          print('adding category: $category');
          categorizedFood[category] = List<Food>();
        }
        for(var item in data['items']) {
          print('item is $item');
          categorizedFood[item['Category']].add(Food.fromData(item));
        }
        return categorizedFood;
      } else {
        var food = List<Food>();
        for(var item in data['items']) {
          print('item is $item');
          food.add(Food.fromData(item));
        }
        return food;
      }
    }
  }

  Future getCanteenInfo() async {
    var data = await _webService.performGetRequest(endPoint: '/getcanteen.php');
    if(data is String) {
      return data;
    }
    _canteens = List<Canteen>();
    for(Map<String, dynamic> item in data) {
      _canteens.add(Canteen.fromData(item));
    }
    return true;
  }

}