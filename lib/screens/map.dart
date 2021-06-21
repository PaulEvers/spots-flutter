import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart';
import 'package:spots/screens/permissions.dart';
import 'package:spots/screens/spot.dart';
import 'package:spots/services/services.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;
  SpotService _spotService = getIt<SpotService>();
  AuthService _authService = getIt<AuthService>();
  Location _location = new Location();
  final Map<String, Marker> _markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationData>(
        stream: _location.onLocationChanged,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasError) {
            return PermissionsScreen();
          }
          return _buildMap();
        });
  }

  Widget _buildMap() {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        compassEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Sign out'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    controller.setMapStyle(_mapStyle);
    _createMarkers();
  }

  void _createMarkers() async {
    final spots = await _spotService.getAllSpots();
    setState(() {
      _markers.clear();
      for (final spot in spots) {
        final marker = Marker(
            markerId: MarkerId(spot.id),
            position:
                LatLng(spot.coordinates.latitude, spot.coordinates.longitude),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpotInfoScreen(spot: spot),
                ),
              );
            });
        _markers[spot.id] = marker;
      }
    });
  }

  Future<void> _goToTheLake() async {
    // Navigator.pushNamed(context, '/spot');
    await _authService.signOut();
  }
}
