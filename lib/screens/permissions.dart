import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PermissionsScreen extends StatefulWidget {
  PermissionsScreen({Key key}) : super(key: key);

  @override
  _PermissionsScreenState createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  Location _location = new Location();
  String _errorMessage = "";
  bool _deniedForever = false;

  @override
  void initState() {
    super.initState();
    _enablePermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1000,
        child: Column(
          children: [
            Text("Please enable permissions!"),
            ElevatedButton(
                onPressed: _enablePermissions, child: Text('Enable')),
            Text(_errorMessage)
          ],
        ),
      ),
    );
  }

  void _enablePermissions() async {
    await _location.requestPermission().then((result) {
      setState(() {
        if (result == PermissionStatus.deniedForever) {
          _deniedForever = true;
          _errorMessage =
              "Please go to your settings to enable location services.";
          return;
        }

        _deniedForever = false;
        _errorMessage = "";
      });
    });
  }
}
