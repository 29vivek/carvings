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
import 'package:carvings/viewmodels/base_model.dart';

class BrowseViewModel extends BaseModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final FoodService _foodService = locator<FoodService>();
  final DialogService _dialogService = locator<DialogService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  List<Canteen> _canteens;
  List<Canteen> get canteens => _canteens;

  List<Food> _favourites;
  List<Food> get favourites => _favourites;
  
  String _role = '';
  String get role  => _role;

  void _findRole() {
    _role = _authenticationService.currentUser.role;
    notifyListeners();
  }

  void navigateToCanteen(int canteenId) {
    _navigationService.navigateTo(CanteenViewRoute, arguments: canteenId);
  }

  void getCanteens() async {

    _findRole();

    var result = await _foodService.getCanteenInfo();
    _canteens = _foodService.canteens;
    if(result is String) {
      _dialogService.showDialog(title: 'Error Occurred!', description: result);
    }
    // else all went fine.
    // fetch everything to update the first time.
    if(_role == 'User') 
      fetchFavourites();
    else {
      _favourites = [];
      notifyListeners();
    }
}

  void getFavourites() async {

    var ids = await _databaseService.getFavouriteIds();
    
    //to handle case where there is no favs
    if(ids.isNotEmpty) {
      var availabilities = await _foodService.getAvailabilityForIds(ids: ids);
    
      if(availabilities is String) {
        _dialogService.showDialog(
          title: 'Error occurred!',
          description: availabilities // lol
        );
        return;
      }
      
      await _databaseService.updateAvailabilities(ids, availabilities);
      // to check if availability is changed from admin side, frequently

      _favourites = null;
      // to show flashy animation more often, isnt actually needed
    }

    setBusy(true);

    var result = await _databaseService.getFavourites();
    _favourites = result;
    
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

  void removeFromFavourites(Food food) async {
    
    await _databaseService.deleteFavourite(food.id);
    getFavourites();

  }

  void fetchFavourites() async {

    var ids = await _databaseService.getFavouriteIds();
    
    //to handle case where there is no favs
    if(ids.isNotEmpty) {
      var food = await _foodService.getFoodFodIds(ids: ids);
    
      if(food is String) {
        _dialogService.showDialog(
          title: 'Error occurred!',
          description: food // lol
        );
        return;
      }
      
      await _databaseService.updateAllFood(food);
      // update all the food params like ratings and all, once per app launch.
    }

    setBusy(true);

    var result = await _databaseService.getFavourites();
    _favourites = result;
    
    setBusy(false);

  }

  void navigateToAddFood() {
    _navigationService.navigateTo(ModifyViewRoute);
  }

  void toggleAvailability(bool availability) async {

    var response = await _dialogService.showConfirmationDialog(
      title: 'Toggle Availability',
      description: 'Mark all food items as ${availability ? 'available' : 'unavailable'}?',
      confirmationTitle: 'Yes',
      cancelTitle: 'So this is what this does',
    );

    if(response.confirmed) {
      var result = await _foodService.toggleAvailability(availability: availability);
      if(result is String) {
        _dialogService.showDialog(
          title: 'Error Occurred',
          description: result
        );
      }
      // else im good actually.
    }
  }

  void editCanteen(int i) {
    _navigationService.navigateTo(ModifyViewRoute, arguments: _canteens[i]);
  }

  void navigateToCategories(bool isAdd) {
    _navigationService.navigateTo(CategoryViewRoute, arguments: isAdd);
  }



}