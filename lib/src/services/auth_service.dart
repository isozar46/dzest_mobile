import 'dart:convert';
import 'dart:io';

import 'package:dzest_mobile/src/models/User.dart';
import 'package:dzest_mobile/src/services/base_api.dart';
import 'package:dzest_mobile/src/services/sharedpref_manager.dart';
import 'package:http/http.dart' as http;

class AuthService extends BaseAPI {
  Future<String?> login(String username, String password) async {
    var body = jsonEncode({'username': username, 'password': password});

    http.Response response = await http.post(
      Uri.parse(super.authPath + '/login/'),
      headers: super.headers,
      body: body,
    );
    if (response.statusCode == 200) {
      var json = response.body;
      var data = jsonDecode(json);
      String token = data['key'];
      return token;
    }
    return null;
  }

  Future<User?> user_details() async {
    String? token = await getToken();

    headers = {
      ...super.headers,
      HttpHeaders.authorizationHeader: "Token $token",
    };
    http.Response response = await http.get(
      Uri.parse(BaseAPI.api + '/user_details/'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
    return null;
  }

  void logout(token) async {
    final headers = {
      ...super.headers,
      HttpHeaders.authorizationHeader: "Token $token",
    };
    http.Response response = await http.post(
      Uri.parse(super.authPath + '/logout/'),
      headers: headers,
    );
  }

  Future<String?> register_client(
      String username, String email, String password1, String password2) async {
    var body = jsonEncode(
        {'username': username, 'email': email, 'password1': password1, 'password2': password2});

    http.Response response = await http.post(
      Uri.parse(super.authPath + '/registration/client/'),
      headers: super.headers,
      body: body,
    );
    if (response.statusCode == 201) {
      var json = response.body;
      return jsonDecode(json);
    }
    return null;
  }

  Future<String?> register_agency(
      String username, String email, String password1, String password2, String name) async {
    var body = jsonEncode({
      'username': username,
      'email': email,
      'password1': password1,
      'password2': password2,
      'name': name
    });

    http.Response response = await http.post(
      Uri.parse(super.authPath + '/registration/agency/'),
      headers: super.headers,
      body: body,
    );
    if (response.statusCode == 201) {
      var json = response.body;
      return jsonDecode(json);
    }
    return null;
  }
}
