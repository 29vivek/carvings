import 'package:carvings/locator.dart';
import 'package:carvings/managers/dialog_manager.dart';
import 'package:carvings/services/dialog_service.dart';
import 'package:carvings/services/navigation_service.dart';
import 'package:carvings/ui/router.dart';
import 'package:carvings/ui/views/startup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(MyApp());
  } catch(e) {
    print('Locator setup has failed.');
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      android: (_) => MaterialAppData(
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xffcd3333),
        ),
      ),
      ios: (_) => CupertinoAppData(
        theme: CupertinoThemeData(
          primaryColor: CupertinoDynamicColor.withBrightness(
            color: Color(0xffcd3333), 
            darkColor: Color(0xffcd3333),
          ),
        ),
      ),
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigatorKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      title: 'Carvings',
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}