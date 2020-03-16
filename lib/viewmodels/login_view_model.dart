import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends BaseModel {
  
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future login({
    @required String email, @required String password
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(email: email, password: password);

    setBusy(false);

    if(result is bool) {
      if(result)
        _navigationService.popAllAndNavigateTo(HomeViewRoute);
    }
    else {
      _dialogService.showDialog(
          title: 'Error occured!',
          description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }

  

}