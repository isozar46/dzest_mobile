import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/services/sharedpref_manager.dart';
import 'package:dzest_mobile/src/views/agency_main_screen.dart';
import 'package:dzest_mobile/src/views/client_main_screen.dart';
import 'package:dzest_mobile/src/views/home_page.dart';
import 'package:dzest_mobile/src/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future checkFirstSeen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _seen = (await getSeen())!;
    bool isAgency = (await getAgency())!;
    bool isClient = (await getClient())!;

    if (_seen) {
      if (isAgency) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new AgencyMainScreen()));
      }
      if (isClient) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new ClientMainScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new MainScreen()));
      }
    }
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Row(
            children: [
              const Text(
                'skip',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (context) => new MainScreen()));
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 150),
                    child: Image.asset(
                      "assets/images/vertical-logo.png",
                      width: 150,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: ElevatedButton(
                          child: const Text(
                            'Sign UP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 3, color: AppColors.primaryColor),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
