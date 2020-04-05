import 'package:carvings/locator.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/models/order.dart';
import 'package:carvings/services/web_service.dart';
import 'package:flutter/foundation.dart';

class FoodService {
  
  final WebService _webService = locator<WebService>();

  List<Canteen> _canteens;
  List<Canteen> get canteens => _canteens;

  Future getFoodItemsFor({@required int canteenId}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/getfood.php',
      formData: { 'canteenId': canteenId },
    );
    if(data is String) {
      return data;
    } else {
      var categorizedFood = Map<String, List<Food>>();
      for(var category in data['categories']) {
        // print('adding category: $category');
        categorizedFood[category] = List<Food>();
      }
      for(var item in data['items']) {
        categorizedFood[item['CategoryName']].add(Food.fromData(item));
      }
      return categorizedFood;
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

  Future getAvailabilityForIds({@required List<dynamic> ids}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/getavailability.php', 
      formData: { 'ids' : ids }
    );
    return data;
  }

  Future getFoodFodIds({@required List<dynamic> ids}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/getfoodforids.php',
      formData: { 'ids' : ids }
    );
    return data;
  }

  Future placeOrder({@required Map<String, dynamic> bundle}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/placeorder.php',
      formData: bundle,
    );
    if(data is String) {
      return data;
    } else if(data['code'] == '0') {
      return data['message'];
    } else {
      // data['message'] is also valid message
      return true;
    }
  }

  Future getSearchedFoodItems({@required keyword}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/search.php',
      formData: { 'keyword': keyword },
    );
    if(data is String) {
      return data;
    } else {
      var food = List<Food>();
      for(var item in data) {
        food.add(Food.fromData(item));
      }
      return food;
    }
  }

  Future getOrders({@required int userId, String filter}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/orders.php',
      formData: {
        'userId' : userId,
        'filter' : filter,
      },
    );
    if(data is String) {
      return data;
    } else {
      var orders = List<Order>();
      for(var order in data) {
        orders.add(Order.fromData(order));
      }
      return orders;
    }
  }

  Future rateFood({@required int orderItemId, int rating}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/ratefood.php',
      formData: {
        'orderItemId' : orderItemId,
        'rating' : rating,
      },
    );
    if(data is String)
      return data;
    else
      return true;
  }

  Future toggleAvailability({@required bool availability}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/toggleavailability.php',
      formData: {
        'value': availability ? 1 : 0,
      }
    );
    if(data is String)
      return data;
    else 
      return true;
  }

  Future modifyFood({@required String name, @required int price, @required int categoryId, @required int foodId}) async {
    var data = await _webService.performPostRequest(
      endPoint: '/modifyfood.php',
      formData: {
        'name' : name,
        'price' : price,
        'categoryId' : categoryId,
        'id' : foodId,      
      }
    );
    if(data is String)
      return data;
    else 
      return true;
  }

  Future modifyCanteen({@required String name, @required String description, @required int canteenId}) async {
    var result = await _webService.performPostRequest(
      endPoint: '/modifycanteen.php',
      formData: {
        'name' : name,
        'description' : description,
        'canteenId' : canteenId
      }
    );

    if(result is String) 
      return result;
    else 
      return true;

  }

}