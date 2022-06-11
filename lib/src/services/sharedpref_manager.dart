import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("key", value);
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("key");
}

Future<bool> setSeen() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("seen", true);
}

Future<bool> setAgency() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("is_agency", true);
}

Future<bool?> getAgency() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("is_agency");
}

Future<bool> setClient() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool("is_client", true);
}
