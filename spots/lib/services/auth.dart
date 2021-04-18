import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';

GetIt getIt = GetIt.instance;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase user one-time fetch
  User get getUser => _auth.currentUser;

  Future<User> emailSignIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<String> getToken() {
    return getUser.getIdToken();
  }
}
