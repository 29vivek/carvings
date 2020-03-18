import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
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

  bool _canBeSaved = false;
  get canBeSaved => _canBeSaved;

  void getUser() {
    _user = _authenticationService.currentUser;
  }

  String _selectedFilter = 'All';
  String get selectedFilter => _selectedFilter;


  void logout() {

    _dialogService.showConfirmationDialog(
      title: 'Do you want to log out?',
      description: 'You\'ll have to log back in.',
      confirmationTitle: 'Yes',
      cancelTitle: 'I changed my mind',
    ).then((response) {
        if(response.confirmed) {
          setBusy(true);
          var result = _authenticationService.logout();
          setBusy(false);
          if(result) {
            _navigationService.popAllAndNavigateTo(LoginViewRoute);
          }
        }
      });

  }

  void setSelectedFilter(dynamic filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void saveDetails(String newName, String newNumber) {
    if(newNumber != '' && newNumber.length != 10) {
      _dialogService.showDialog(
        title: 'Error occurred!',
        description: 'Fill in details as required.'
      );
    }
  }

  void couldBeSaved(String s) {
    if(s == '')
      _canBeSaved = false;
    else
      _canBeSaved = true;
    
    notifyListeners();
  }

}