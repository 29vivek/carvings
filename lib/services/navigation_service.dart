import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      Get.key;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return Get.toNamed(routeName, arguments: arguments);
  }

  bool goBack() {
    return Get.back();
  }

  Future<dynamic> popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    return Get.offAllNamed(routeName, predicate: (_) => false, arguments: arguments);
  }
  
}