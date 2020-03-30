import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/services/database_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/navigation_service.dart';

import 'base_model.dart';

class CanteenViewModel extends BaseModel {

  final FoodService _foodService = locator<FoodService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  Map<String, List<Food>> _categorizedFood;

  Map<String, List<Food>> get food => _categorizedFood;

  Canteen _canteen;
  Canteen get canteen => _canteen;

  void getFoodItems(int canteenId) async {
    
    _canteen = _foodService.canteens[canteenId - 1]; // nice litte hack #2

    _categorizedFood = null;
    setBusy(true);

    var result = await _foodService.getFoodItemsFor(canteenId: canteenId);
    if(result is String) {
      await _dialogService.showDialog(title: 'Error Occurred!', description: result);
      // go back to browse view.
      _navigationService.goBack();
    } else {
      // got me my food (dabs)
      _categorizedFood = result;
    }
    
    setBusy(false);
    
  }

  void addToCart(Food food) async {
    
    setBusy(true);

    SheetResponse response = await _bottomSheetService.showFoodSheet(
      title: '${food.name}',
      subtitle: food.canteenName,
      price: food.price,
      description: food.category,
      rating: '${food.rating} stars based on ${food.numberRatings} ratings.'
    );

    if(response.confirmed) {
      // add to cart
    }

    setBusy(false);

  }

  void addToFavourites(Food food) async {
    
    setBusy(true);

    var result = await _databaseService.insertFavourite(food);
    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: result,
      );
    }
    // else im good actually.

    setBusy(false);

  }
}