import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dzest_mobile/src/constants/app_colors.dart';
import 'package:dzest_mobile/src/services/auth_service.dart';
import 'package:dzest_mobile/src/views/client/client_profile.dart';
import 'package:dzest_mobile/src/views/client/favourites.dart';
import 'package:dzest_mobile/src/views/home_page.dart';
import 'package:dzest_mobile/src/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientMainScreen extends StatefulWidget {
  ClientMainScreen({Key? key}) : super(key: key);

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(
      title: 'Dzest',
    ),
    Favourites(),
    ClientProfile(),
  ];

  void deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //setState(() {
    preferences.remove('key');
    preferences.remove('is_agency');
    preferences.remove('is_client');
    preferences.remove('client_id');
    preferences.remove('agency_id');
    preferences.setBool("seen", false);
    //});
  }

  @override
  void initState() {
    super.initState();
    //getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.title),
        //leading: null, // 1
        title:
            Image.asset("assets/images/horizontal-logo.png", width: 110), // 2
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  AuthService().logout();
                  deleteToken();
                  //Navigator.pushReplacementNamed(context, '/welcome');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                  elevation: 0,
                ),
                child: Text('Log out')),
          )
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: AppColors.primaryColor,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.favorite, title: 'Favourites'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        //initialActiveIndex: 0, //optional, default as 0
        onTap: (int i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
