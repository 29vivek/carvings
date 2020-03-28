import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class BrowseViewModel extends BaseModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final FoodService _foodService = locator<FoodService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Canteen> _canteens;
  List<Canteen> get canteens => _canteens;

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
    notifyListeners();
  }

}