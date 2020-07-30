import 'package:flutter/material.dart';
import 'package:servio/screens/home_screen.dart';
import 'package:servio/screens/alerts.dart';
import 'package:servio/screens/favorites.dart';
import 'package:servio/screens/profile.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/demo_http.dart';

class MainParentScreen extends StatefulWidget {
  static String id = 'parentScreen';

  @override
  _MainParentScreenState createState() => _MainParentScreenState();
}

class _MainParentScreenState extends State<MainParentScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      //todo when a menu is clicked
      _selectedIndex = index;
    });
  }

  var _screens = <Widget>[
    //HomeScreen(),
    Categories(),
    AlertsScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],//body will be whatever screen is represented by the index
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category), //todo Return this => icon: Icon(Icons.home),
            title: Text('Categories'),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Alerts'),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
            backgroundColor: kPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: kPrimaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }
}
