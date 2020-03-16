import 'package:carvings/services/authentication_service.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/localstorage_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());

  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton(instance);

  locator.registerLazySingleton(() => AuthenticationService());

}