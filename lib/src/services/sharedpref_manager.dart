import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesManager {
  void loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    /*setState(() {
      token = (prefs.getString('key') ?? '0');
    });*/
  }
}
