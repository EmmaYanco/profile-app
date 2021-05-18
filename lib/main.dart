import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'data/theme.dart';
import 'utils/router.dart' as router;
import 'utils/navigation.dart';
import 'data/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    // Sets the initial screen to either login or main, depending on
    // logged-in status.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: '/profile',
      // theme: light,
      // darkTheme: dark,
      // themeMode: currentTheme.theme(),
    );
  }

}
