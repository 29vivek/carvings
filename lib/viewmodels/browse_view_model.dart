import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
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

  List<Canteen> _canteens;
  List<Canteen> get canteens => _canteens;

  List<Food> _favourites;
  List<Food> get favourites => _favourites;

  void navigateToCanteen(int canteenId) {
    _navigationService.navigateTo(CanteenViewRoute, arguments: canteenId);
  }

  void getCanteens() async {
    var result = await _foodService.getCanteenInfo();
    _canteens = _foodService.canteens;
    if(result is String) {
      _dialogService.showDialog(title: 'Error Occurred!', description: result);
    }
    // else all went fine.
    getFavourites();
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
      // add to cart
    }

    setBusy(false);
  }

  void removeFromFavourites(Food food) async {
    
    await _databaseService.delete(food.id);
    getFavourites();

  }



}