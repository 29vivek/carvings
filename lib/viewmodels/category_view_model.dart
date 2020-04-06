import 'package:carvings/locator.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class CategoryViewModel extends BaseModel {

  final FoodService _foodService = locator<FoodService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Map<String, List> _categories;
  Map<String, List> get categories => _categories;

  String _selectedCanteen = 'Select a Canteen';
  String get selectedCanteen => _selectedCanteen;

  String _selectedCategory = 'Select a Category';
  String get selectedCategory => _selectedCategory;

  void getCategories() {
    var canteens = _foodService.canteens;
    _categories = {};
    for(var canteen in canteens) {
      _categories[canteen.name] = canteen.categories;
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

  void performAction(String text, bool isAdd) async {
    if(isAdd) {
      if(_selectedCanteen == 'Select a Canteen') {
        _dialogService.showDialog(
          title: 'Error Occurred!',
          description: 'You must select a canteen.',
        );
      } else if(text.isEmpty) {
        _dialogService.showDialog(
          title: 'Error Occurred!',
          description: 'Category names cannot be blank.',
        );
      } else if(_categories[_selectedCanteen].map((category) => category.categoryName).toList().contains(text.trim())) {
        _dialogService.showDialog(
          title: 'Error Occurred!',
          description: 'This category already exists.',
        );
      } else {

        setBusy(true);

        var canteenId = _foodService.canteens.firstWhere((canteen) => canteen.name == _selectedCanteen).id;
        var result = await _foodService.modifyCategory(canteenId: canteenId, newCategoryName: text);
        if(result is String) {
          _dialogService.showDialog(
            title: 'Error Occurred!',
            description: result,
          );
          setBusy(false);
        
        } else {

          setBusy(false);
          _foodService.getCanteenInfo();
          _navigationService.goBack();
        
        }

      }
    } else {
      if(_selectedCanteen == 'Select a Canteen' || _selectedCategory == 'Select a Category') {
        _dialogService.showDialog(
          title: 'Error Occurred!',
          description: 'Select which category to delete and from which canteen.',
        );
      } else {

        setBusy(true);

        var id = _categories[_selectedCanteen].firstWhere((category) => category.categoryName == _selectedCategory).categoryId;
        var result = await _foodService.modifyCategory(categoryId: id);
        if(result is String) {
          _dialogService.showDialog(
            title: 'Error Occurred',
            description: result,
          );
          setBusy(false);

        } else {

          setBusy(false);
          _foodService.getCanteenInfo();
          _navigationService.goBack();
        }

      }
    }
    
  }

}