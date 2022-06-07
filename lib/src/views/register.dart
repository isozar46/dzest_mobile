import 'package:dzest_mobile/src/views/home_page.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class RegisterChoice extends StatelessWidget {
  const RegisterChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/horizontal-logo.png",
                    width: 200,
                  ),
                  const Text(
                    'Set your goals!',
                    style: TextStyle(
                      color: AppColors.titleColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'At Dzest you can choose between two different types of accounts, to buy or rent a property then start with a Personal account, or you can start as an Agency account if you are a real estate agency thats looking to take their business to the next level!',
                    style: TextStyle(
                      color: AppColors.textColor,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/undraw_Choice_re_2hkp.png",
                      width: 300,
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
                            'Sign Up as Client',
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
                            Navigator.pushNamed(context, '/clientsignup');
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: ElevatedButton(
                          child: const Text(
                            'Sign Up as Agency',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(width: 3, color: AppColors.primaryColor),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // <-- Radius
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/agencysignup');
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
