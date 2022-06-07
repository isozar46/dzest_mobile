import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dzest_mobile/src/views/client/favourites.dart';
import 'package:dzest_mobile/src/views/home_page.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  var isAgency = false;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(
      title: 'Dzest',
    ),
    Favourites(),
    //ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Offer'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, '/addoffer');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        //title: Text(widget.title),
        //leading: null, // 1
        title: Image.asset("assets/images/horizontal-logo.png", width: 110), // 2
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                  elevation: 0,
                ),
                child: Text('Login')),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: AppColors.primaryColor,
        items: isAgency
            ? [
                TabItem(icon: Icons.home, title: 'Home'),
                TabItem(icon: Icons.list, title: 'My Offers'),
                TabItem(icon: Icons.person, title: 'Profile'),
              ]
            : [
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
