import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/models/cart_item.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/services/database_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class SearchViewModel extends BaseModel {

  final FoodService _foodService = locator<FoodService>();
  final DialogService _dialogService = locator<DialogService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  List<Food> _searchedItems;
  List<Food> get searchedItems => _searchedItems;

  void getFoodItems(String keyword) async {
    
    _searchedItems = null;
    if(keyword != '') {
      var data = await _foodService.getSearchedFoodItems(keyword: keyword);
      if(data is String) {
        _dialogService.showDialog(
          title: 'Error Occurred!',
          description: data,
        );
      } else {
        _searchedItems = data;
      }
    }
    notifyListeners();
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

}