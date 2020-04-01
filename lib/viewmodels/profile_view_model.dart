import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/bottomsheet_models.dart';
import 'package:carvings/models/dialog_models.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class ProfileViewModel extends BaseModel {

  AuthenticationService _authenticationService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  NavigationService _navigationService = locator<NavigationService>();

  User _user;
  User get user => _user;

  void getUser() {
    _user = _authenticationService.currentUser;
    notifyListeners();
  }


  String _selectedFilter = 'Today';
  String get selectedFilter => _selectedFilter;


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

  void setSelectedFilter(dynamic filter) {
    _selectedFilter = filter;
    notifyListeners();
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

}