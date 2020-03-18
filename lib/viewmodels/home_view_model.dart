import 'package:carvings/locator.dart';
import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  int _index = 0;
  int get index => _index;

  String _role = '';
  String get role  => _role;

  AuthenticationService _authenticationService = locator<AuthenticationService>();

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void findRole() {
    _role = _authenticationService.currentUser.role;
  }

}