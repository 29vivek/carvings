import 'package:get/get.dart';

class NavigationService {

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return Get.toNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return Get.back();
  }

  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    return Get.offAllNamed(routeName, predicate: (_) => false, arguments: arguments);
  }
  
}