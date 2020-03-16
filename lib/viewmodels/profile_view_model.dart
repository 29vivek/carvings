import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/models/user.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class ProfileViewModel extends BaseModel {
  User _user;

  User get user => _user;

  LocalStorageService _storageService = locator<LocalStorageService>();
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();


  void getUser() {
    _user = _storageService.user;
  }

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

}