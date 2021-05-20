import 'package:Breakthrough_Profile/user/profile.dart';
import 'package:Breakthrough_Profile/utils/backend/userInteraction.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'utils/router.dart' as router;
import 'utils/navigation.dart';

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

  UserAccount userAccount;

  // Grabs user from backend
  void getUser() async {
    UserAccount currentUser = await UserInteraction().loadCurrentUser();
    this.userAccount = currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    getUser();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
      home: this.userAccount == null
        // Waits until userAccount is grabbed to build ProfilePage
        ? Container()
        : ProfilePage(this.userAccount),
    );
  }

}
