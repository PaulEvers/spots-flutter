import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
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
  final Map<String, Marker> _markers = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkers();
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
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    controller.setMapStyle(_mapStyle);
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
