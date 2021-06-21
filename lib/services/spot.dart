import 'dart:convert';

import 'package:spots/models/models.dart';
import 'package:spots/services/auth.dart';

import 'package:http/http.dart' as http;

class SpotService {
  AuthService _authService = getIt<AuthService>();
  List<Spot> _spots = [];

  Future<List<Spot>> getAllSpots() async {
    if (_spots.length == 0) {
      await _fetchSpots();
    }

    print(_spots);

    return _spots;
  }

  Future<void> _fetchSpots() async {
    String token = await _authService.getToken();
    print(token);
    var headers = {'Authorization': token};
    print(token);
    var url = Uri.parse('https://10.0.2.2:443/spots');
    var response = await http.get(url, headers: headers);

    List<Spot> spots = [];
    dynamic jsonList = jsonDecode(response.body);
    jsonList.forEach((json) {
      Spot spot = Spot.fromJson(json);
      spots.add(spot);
    });

    _spots = spots;
  }
}
