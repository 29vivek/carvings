import 'package:carvings/ui/views/canteen_view.dart';
import 'package:carvings/ui/views/category_view.dart';
import 'package:carvings/ui/views/home_view.dart';
import 'package:carvings/ui/views/modify_view.dart';
import 'package:carvings/ui/views/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:carvings/constants/route_names.dart';
import 'package:carvings/ui/views/login_view.dart';
import 'package:carvings/ui/views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case StartUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartUpView(),
      );
    case CanteenViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CanteenView(canteenIndex: settings.arguments,),
      );
    case ModifyViewRoute: 
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ModifyView(item: settings.arguments),
      );
    case CategoryViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CategoryView(isAdd: settings.arguments,),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => SafeArea(child: viewToShow));
}
