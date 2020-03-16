import 'package:carvings/locator.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  int _index = 0;
  int get index => _index;

  String _role = '';
  String get role  => _role;

  LocalStorageService _storageService = locator<LocalStorageService>();

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void findRole() {
    _role = _storageService.user.role;
    print(_role);
  }

}