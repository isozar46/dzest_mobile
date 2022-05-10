import 'package:dzest_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences? prefs;
  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs?.getInt("key") ?? 0;
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
              Text(getSharedPreferences().toString()),
            ],
          ),
        ),
      ),
    );
  }
}
