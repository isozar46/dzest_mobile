import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/User.dart';
import 'package:dzest_mobile/src/services/sharedpref_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dzest_mobile/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoaded = true;
  User? user;

  savePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (user!.isClient == true) {
      setClient();
    }
    if (user!.isAgency == true) {
      setAgency();
    }
    if (user!.clientId != null) {
      preferences.setInt("client_id", user!.clientId);
    }
    if (user!.agencyId != null) {
      preferences.setInt("agency_id", user!.agencyId);
    }
    preferences.setInt("user_id", user!.id);
  }

  getData() async {
    user = await AuthService().user_details();
    savePref();
  }

  sendData(username, password) async {
    String? key = await AuthService().login(username, password);
    if (key != null) {
      setState(() {
        setToken(key);
        setSeen();
        getData();
        isLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Login"),
        elevation: 0,
      ),
      body: Visibility(
        visible: isLoaded,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/horizontal-logo.png",
                      width: 200,
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20, color: AppColors.textColor),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
                  child: TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      floatingLabelStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                ),
                Container(
                  width: 60,
                  padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 60,
                    width: 200,
                    padding: const EdgeInsets.fromLTRB(38, 0, 38, 0),
                    child: ElevatedButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        sendData(usernameController.text, passwordController.text);

                        Navigator.pop(context);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
