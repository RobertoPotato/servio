import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
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
    );
  }
}
