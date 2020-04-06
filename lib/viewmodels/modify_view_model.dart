import 'package:carvings/locator.dart';
import 'package:carvings/models/canteen.dart';
import 'package:carvings/models/food.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class ModifyViewModel extends BaseModel {

  final FoodService _foodService = locator<FoodService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Map<String, List> _categories;
  Map<String, List> get categories => _categories;

  List<Canteen> _canteens;

  String _selectedCanteen = 'Select a Canteen';
  String get selectedCanteen => _selectedCanteen;

  String _selectedCategory = 'Select a Category';
  String get selectedCategory => _selectedCategory;

  void getCanteens(food) {
    _canteens = _foodService.canteens;
    _categories = {};
    for(var canteen in _canteens) {
      _categories[canteen.name] = canteen.categories;
    }

    if(food != null) {
      _selectedCanteen = (food as Food).canteenName;
      _selectedCategory = (food as Food).category;
    }
    notifyListeners();
  }

  void selectCanteen(String canteen) {
    _selectedCanteen = canteen;
    _selectedCategory = 'Select a Category';
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void modifyFood(String name, String price, int id) async {
    
    setBusy(true);

    if((id == 0 && (name == '' || price == '' || _selectedCanteen == 'Select a Canteen' || _selectedCategory == 'Select a Category')) || (price != '' && int.tryParse(price) == null || _selectedCategory == 'Select a Category')) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: 'Fill in all the required fields correctly.'
      );
    } else {
      // print(_categories[_selectedCanteen].firstWhere((category) => category.categoryName == _selectedCategory).categoryId);
      var result = await _foodService.modifyFood(
        name: name, 
        price: int.tryParse(price), 
        categoryId: _categories[_selectedCanteen].firstWhere((category) => category.categoryName == _selectedCategory).categoryId,
        foodId: id,
      );
      if(result is String) {
        _dialogService.showDialog(
          title: 'Error occurred!',
          description: result
        );
      } else {
        _navigationService.goBack();
      }
      
    }

    setBusy(false);

  }

  void updateCanteenInfo(String fieldOne, String fieldTwo, int canteenId) async {
    var result = await _foodService.modifyCanteen(name: fieldOne, description: fieldTwo, canteenId: canteenId);

    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: result
      );
    } else {
      _navigationService.goBack();
    }

  }

  void deleteFood(int foodId) async {
    
    var response = await _dialogService.showConfirmationDialog(
      title: 'Delete food item?',
      description: 'This item will be irreveresably deleted.',
      confirmationTitle: 'Did I stutter?',
      cancelTitle: 'No',
    );

    if(response.confirmed) {
      var result = await _foodService.deleteFood(foodId);
      if(result is String) {
        _dialogService.showDialog(
          title: 'Error Occurred!',
          description: result,
        );
      } else {
        _navigationService.goBack();
      }
    }
  }


}