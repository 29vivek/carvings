import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/cart_item.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/services/authentication_service.dart';
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
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  Map<String, List<Food>> _categorizedFood;

  Map<String, List<Food>> get food => _categorizedFood;

  Canteen _canteen;
  Canteen get canteen => _canteen;

  String _role = '';
  String get role  => _role;

  void _findRole() {
    _role = _authenticationService.currentUser.role;
    notifyListeners();
  }

  void getFoodItems(int canteenIndex) async {

    _findRole();

    _canteen = _foodService.canteens[canteenIndex]; // index

    // for flashy animation 
    _categorizedFood = null;
    setBusy(true);

    var result = await _foodService.getFoodItemsFor(canteenId: canteenIndex + 1);
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
      await _databaseService.insertToCart(
        CartItem(foodId: food.id, foodName: food.name, canteeenName: food.canteenName, quantity: response.number, price: food.price)
      );
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

  void editFood(Food food) async {
    _navigationService.navigateTo(ModifyViewRoute, arguments: food);
  }

}