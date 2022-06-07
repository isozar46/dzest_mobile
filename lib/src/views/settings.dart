//import 'package:dzest_mobile/services/sharedpref_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dzest_mobile/src/services/auth_service.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late String token;

  void loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('key') ?? '0';
    });
  }

  void deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //setState(() {
    preferences.remove('key');
    preferences.setBool("seen", false);
    //});
  }

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Text('auth token: '),
              Expanded(child: Text(token)),
              ElevatedButton(
                onPressed: () {
                  AuthService().logout(token);
                  deleteToken();
                },
                child: const Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
