import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/dialog_models.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class ProfileViewModel extends BaseModel {

  AuthenticationService _authenticationService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();

  User _user;
  User get user => _user;

  void getUser() {
    _user = _authenticationService.currentUser;
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
      var result = _authenticationService.logout();
      if(result) {
        _navigationService.popAllAndNavigateTo(LoginViewRoute);
      }
    }

  }

  void setSelectedFilter(dynamic filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void saveDetails(String newName, String newNumber) async {
    
    setBusy(true);

    if(newNumber != '' && newNumber.length != 10) {
      await _dialogService.showDialog(
        title: 'Error occurred!',
        description: 'Fill in details as required.'
      );
    } else if(newName == '' && newNumber == '') {
      await _dialogService.showDialog(
        title: 'Error occurred!',
        description: 'No fields changed to update.'
      );
    } else {
      var result = await _authenticationService.editUserDetails(email: _user.email, name: newName, number: newNumber);
      if(result is bool) {
        if(result) {
          getUser();
          setBusy(false);
          _navigationService.goBack();
          return;
        }
      }
      else {
        _dialogService.showDialog(
            title: 'Error occured!',
            description: result,
        );
      }
    }

    setBusy(false);
    
  }

}