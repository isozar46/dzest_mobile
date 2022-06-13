import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/models/User.dart';
import 'package:dzest_mobile/src/services/auth_service.dart';
import 'package:dzest_mobile/src/services/sharedpref_manager.dart';
import 'package:dzest_mobile/src/views/agency_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgencySignUp extends StatefulWidget {
  const AgencySignUp({Key? key}) : super(key: key);

  @override
  State<AgencySignUp> createState() => _AgencySignUpState();
}

class _AgencySignUpState extends State<AgencySignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  getData(username, email, password1, password2, name) async {
    String? key = await AuthService()
        .register_agency(username, email, password1, password2, name);
    setToken(key!);
    setSeen();
    setAgency();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Text("Login"),
        elevation: 0,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
              child: const Text(
                'Sign Up as Agency!',
                style: TextStyle(
                  color: AppColors.titleColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
              child: const Text(
                'Creating a new account at Dzest is as easy as clicking a few buttons and you dont need to submit any personal papers!',
                style: TextStyle(
                  color: AppColors.textColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(color: AppColors.textColor),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field cant be empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Agency name',
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(color: AppColors.textColor),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field cant be empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(color: AppColors.textColor),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field cant be empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
              child: TextFormField(
                controller: password1Controller,
                obscureText: true,

                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(color: AppColors.textColor),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field cant be empty';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 30),
              child: TextFormField(
                obscureText: true,

                controller: password2Controller,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Repeat Password',
                  floatingLabelStyle: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(color: AppColors.textColor),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field cant be empty';
                  }
                  if (value != password1Controller.text) {
                    return 'passwords has to be the same';
                  }

                  return null;
                },
              ),
            ),
            Container(
              height: 60,
              width: 200,
              padding: const EdgeInsets.fromLTRB(38, 0, 38, 0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    getData(
                        usernameController.text,
                        emailController.text,
                        password1Controller.text,
                        password2Controller.text,
                        nameController.text);
                    //Navigator.pushReplacementNamed(context, '/agencyscreen');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AgencyMainScreen()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: const Text(
                  'Sign Up',
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
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
              child: const Text(
                'By signing up you are agreeing to our',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(38, 10, 38, 0),
              child: const Text(
                'Terms and Conditons',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
