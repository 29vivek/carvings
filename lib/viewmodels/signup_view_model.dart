import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future signUp({
    @required String email, @required String name,
    @required String number, @required String password,
  }) async {

    if(email.isEmpty || name.isEmpty || number.length != 10 || password.length < 6) {
      _dialogService.showDialog(
          title: 'Error occured!',
          description: 'Fill in details as required.',
      );
      return;
    }

    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(email: email, name: name, number: number, password: password);

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
}