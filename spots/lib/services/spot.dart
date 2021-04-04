import 'package:spots/services/auth.dart';

import 'package:http/http.dart' as http;

class SpotService {
  AuthService _authService = AuthService();

  Future<String> getAllSpots() async {
    String token = await _authService.getToken();
    var headers = {'Authorization': token};
    var url = Uri.parse('http://10.0.2.2:8080/spots');
    var response = await http.get(url, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.body;
  }
}
