import 'package:carvings/locator.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/navigation_service.dart';

import 'base_model.dart';

class CanteenViewModel extends BaseModel {

  final FoodService _foodService = locator<FoodService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Map<String, List<Food>> _categorizedFood;
  List<Food> _food;
  bool _isCategorized = false;

  dynamic get food => _isCategorized ? _categorizedFood : _food;

  Canteen _canteen;
  Canteen get canteen => _canteen;

  void getFoodItems(int canteenId) async {
    
    _canteen = _foodService.canteens[canteenId - 1]; // nice litte hack #2

    var result = await _foodService.getFoodItemsFor(canteenId: canteenId, categorized: _isCategorized);
    if(result is String) {
      await _dialogService.showDialog(title: 'Error Occurred!', description: result);
      // go back to browse view.
      _navigationService.goBack();
    } else {
      // got me my food (dabs)
      if(_isCategorized)
        _categorizedFood = result;
      else 
        _food = result;
    }
    
    notifyListeners();
  }
}