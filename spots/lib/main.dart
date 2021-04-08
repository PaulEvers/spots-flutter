import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spots/screens/login.dart';
import 'package:spots/screens/map.dart';
import 'package:spots/screens/spot.dart';
import 'package:spots/services/navigation.dart';
import 'package:spots/services/services.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<SpotService>(SpotService());

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      // Theme
      theme: ThemeData(
        fontFamily: 'Nunito',
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black87,
        ),
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 18),
          body2: TextStyle(fontSize: 16),
          button: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold),
          headline: TextStyle(fontWeight: FontWeight.bold),
          subhead: TextStyle(color: Colors.grey),
        ),
        buttonTheme: ButtonThemeData(),
      ),

      // Routes
      navigatorKey: getIt<NavigationService>().navigatorKey,
      routes: {
        '/': (context) => LoginScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
