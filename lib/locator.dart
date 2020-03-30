import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/bottomsheet_service.dart';
import 'package:carvings/services/database_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/food_service.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/services/web_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());

  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton(instance);

  var database = DatabaseService.instance;
  locator.registerSingleton(database);

  var webServiceInstance = WebService.getInstance();
  locator.registerSingleton(webServiceInstance);

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FoodService());
}