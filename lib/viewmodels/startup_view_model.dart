import 'package:carvings/constants/route_names.dart';
import 'package:carvings/locator.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void handleStartUpLogic() {
    var hasLoggedInUser = _authenticationService.hasUserLoggedIn();
    if(hasLoggedInUser)
      _navigationService.popAllAndNavigateTo(HomeViewRoute);
    else
      _navigationService.popAllAndNavigateTo(LoginViewRoute);
  }
  
}
