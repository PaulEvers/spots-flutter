import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spots/screens/landing.dart';
import 'package:spots/screens/map.dart';
import 'package:spots/services/navigation.dart';
import 'package:spots/services/services.dart';

GetIt getIt = GetIt.instance;
void main() async {
  HttpOverrides.global = new CustomHttpOverrides();
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
      title: 'Spots',

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
        '/': (context) => LandingScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
