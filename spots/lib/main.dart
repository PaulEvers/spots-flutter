import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spots/screens/login.dart';
import 'package:spots/screens/map.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/': (context) => LoginScreen(),
              '/map': (context) => MapScreen(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text('Loading');
      },
    );
  }
}
