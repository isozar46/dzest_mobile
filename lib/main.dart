import 'package:dzest_mobile/constants/app_colors.dart';
import 'package:dzest_mobile/views/agency_profile.dart';
import 'package:dzest_mobile/views/auth/login_page.dart';
import 'package:dzest_mobile/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/home_page.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dzest',
      theme: ThemeData(
          fontFamily: 'Nunito',
          primaryColor: AppColors.primaryColor,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: AppColors.primaryColor),
            titleTextStyle: TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'Nunito',
            ),
          )),
      home: const HomePage(title: 'Dzest'),
      routes: {
        '/agencyprofile': (context) => AgencyProfile(),
        '/login': (context) => LoginPage(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
