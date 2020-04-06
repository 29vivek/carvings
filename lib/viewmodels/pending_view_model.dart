import 'package:carvings/locator.dart';
import 'package:carvings/models/order.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class PendingViewModel extends BaseModel {

  final FoodService _foodService = locator<FoodService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Order> _pendingOrders;
  List<Order> get pendingOrders => _pendingOrders;

  void getPendingOrders() async {

    _pendingOrders = null;
    notifyListeners();

    var result = await _foodService.getOrders(
      which: 'Processing',
    );
    
    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: result,
      );
    } else {
      _pendingOrders = result;
    }

    notifyListeners();
  }

  void completeOrder({int orderId}) async {
    var result = await _foodService.completeOrder(orderId);
    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: result,
      );
    } else {
      getPendingOrders();
    }
    notifyListeners();
  }


}