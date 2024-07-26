import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      "DeviceId": "4",
      "otp": "45",
      "grant_type": "password",
      "rememberMe": "false",
      "RequestType": "LOGIN",
      "password": password,
      "username": username,
    };

    final url = Uri.parse('http://misdev.eris.co.in:8096/token');
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      return {"userName": "no value found"};
    }
  }
}
