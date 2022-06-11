import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/views/agency/add_offer.dart';
import 'package:dzest_mobile/src/views/agency_profile.dart';
import 'package:dzest_mobile/src/views/auth/agency_signup.dart';
import 'package:dzest_mobile/src/views/auth/client_signup.dart';
import 'package:dzest_mobile/src/views/auth/login_page.dart';
import 'package:dzest_mobile/src/views/client/favourites.dart';
import 'package:dzest_mobile/src/views/register.dart';
import 'package:dzest_mobile/src/views/settings.dart';
import 'package:dzest_mobile/src/views/welcome.dart';
import 'package:flutter/material.dart';

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
      home: WelcomeScreen(),
      routes: {
        '/agencyprofile': (context) => AgencyProfile(),
        //'/offer': (context) => OfferPage(),
        '/login': (context) => LoginPage(),
        '/settings': (context) => Settings(),
        '/addoffer': (context) => AddOffer(),
        '/register': (context) => RegisterChoice(),
        '/clientsignup': (context) => ClientSignUp(),
        '/agencysignup': (context) => AgencySignUp(),
        '/favourites': (context) => Favourites(),
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}
