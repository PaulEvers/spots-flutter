import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spots/services/services.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = getIt<AuthService>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  StreamSubscription _sub;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _sub = _auth.user.listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/map');
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(
              size: 150,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Email
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  // Password
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      setErrorMessage('');
                      if (_formKey.currentState.validate()) {
                        var email = _emailController.text;
                        var password = _passwordController.text;
                        _auth.emailSignIn(email, password).then((value) => {
                              if (value == null)
                                {
                                  setErrorMessage(
                                      'Incorrect email or password.')
                                }
                            });
                      }
                    },
                    child: Text('Sign in'),
                  ),
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }
}
