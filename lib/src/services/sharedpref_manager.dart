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

Future<bool?> getSeen() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("seen");
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

Future<bool?> getClient() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool("is_client");
}

Future<bool> setClientId(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt("client_id", id);
}

Future<bool> setAgencyId(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt("agency_id", id);
}

Future<bool> setId(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt("user_id", id);
}
