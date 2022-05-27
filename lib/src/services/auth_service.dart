import 'dart:convert';
import 'dart:io';

import 'package:dzest_mobile/src/models/User.dart';
import 'package:dzest_mobile/src/services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthService extends BaseAPI {
  Future<User?> login(String username, String password) async {
    var body = jsonEncode({'username': username, 'password': password});

    http.Response response = await http.post(
      Uri.parse(super.authPath + '/login/'),
      headers: super.headers,
      body: body,
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
    return null;
  }

  /*Future<User?>*/ void logout(token) async {
    final headers = {
      ...super.headers,
      HttpHeaders.authorizationHeader: "Token $token",
    };
    http.Response response = await http.post(
      Uri.parse(super.authPath + '/logout/'),
      headers: headers,
    );
    /*
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
    return null;*/
  }
}
