import 'dart:convert';

import 'package:spots/models/models.dart';
import 'package:spots/services/auth.dart';

import 'package:http/http.dart' as http;

class SpotService {
  AuthService _authService = getIt<AuthService>();

  Future<String> getAllSpots() async {
    String token = await _authService.getToken();
    var headers = {'Authorization': token};
    var url = Uri.parse('http://10.0.2.2:8080/spots');
    var response = await http.get(url, headers: headers);

    List<Spot> spots = [];
    List<dynamic> jsonList = jsonDecode(response.body);
    jsonList.forEach((json) {
      Spot spot = Spot.fromJson(json);
      spots.add(spot);
    });

    return response.body;
  }
}
