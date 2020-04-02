import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/models/dialog_models.dart';
import 'package:carvings/models/order.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class ProfileViewModel extends BaseModel {

  AuthenticationService _authenticationService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  NavigationService _navigationService = locator<NavigationService>();
  FoodService _foodService = locator<FoodService>();

  User _user;
  User get user => _user;

  void getUser() {
    _user = _authenticationService.currentUser;
    notifyListeners();

    _getOrdersForFilter();
  }


  String _selectedFilter = 'Today';
  String get selectedFilter => _selectedFilter;

  List<Order> _orders;
  List<Order> get orders => _orders;

  void _getOrdersForFilter() async {

    _orders = null;
    notifyListeners();

    var result = await _foodService.getOrders(userId: _user.id, filter: _selectedFilter);
    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: result,
      );
    } else {
      _orders = result;
    }

    notifyListeners();
  }

  void setSelectedFilter(dynamic filter) async {
    _selectedFilter = filter;
    notifyListeners();

    _getOrdersForFilter();
  }

  void logout() async {

    DialogResponse response = await _dialogService.showConfirmationDialog(
      title: 'Do you want to log out?',
      description: 'You\'ll have to log back in.',
      confirmationTitle: 'Yes',
      cancelTitle: 'I changed my mind',
    );
    if(response.confirmed) {
      var result = await _authenticationService.logout();
      if(result) {
        _navigationService.popAllAndNavigateTo(LoginViewRoute);
      }
    }

  }
  
  void editDetails() async {
    
    SheetResponse response = await _bottomSheetService.showEditSheet(
      title: 'Edit your Details',
      placeholderOne: _user.name,
      placeholderTwo: _user.number,
    );
    
    if(response.fieldTwo != '' && response.fieldTwo.length != 10) {
      await _dialogService.showDialog(
        title: 'Error occurred!',
        description: 'Fill in details as required.'
      );
    } else if(response.fieldOne == '' && response.fieldTwo == '') {
      await _dialogService.showDialog(
        title: 'Error occurred!',
        description: 'No fields changed to update.'
      );
    } else {
      var result = await _authenticationService.editUserDetails(email: _user.email, name: response.fieldOne, number: response.fieldTwo);
      if(result is bool) {
        if(result) {
          getUser();
          notifyListeners();
        }
      }
      else {
        _dialogService.showDialog(
            title: 'Error occured!',
            description: result,
        );
      }
    }

  }

  void rateFood(int orderItemId, int rating) async {
    var result = await _foodService.rateFood(orderItemId: orderItemId, rating: rating);
    if(result is String) {
      _dialogService.showDialog(
        title: 'Error Occurred!',
        description: 'Your rating may not reflected in the database. Reason: $result',
      );
    } 
    // else im good actually #2
  }

}