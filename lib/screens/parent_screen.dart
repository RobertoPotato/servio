import 'package:flutter/material.dart';
import 'package:servio/screens/home_screen.dart';
import 'package:servio/screens/alerts.dart';
import 'package:servio/screens/favorites.dart';
import 'package:servio/screens/my_services.dart';
import 'package:servio/screens/profile.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/categories.dart';
import 'package:servio/screens/bids.dart';

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
    HomeScreen(),
    Categories(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 250.0,
              child: DrawerHeader(
                child: Image.asset(
                  'images/business_woman.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: (){
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
            ListTile(
              title: Text('Favorites'),
              leading: Icon(Icons.favorite),
              onTap: (){
                Navigator.pushNamed(context, FavoritesScreen.id);
              },
            ),
            ListTile(
              title: Text('Alerts'),
              leading: Icon(Icons.notifications),
              onTap: (){
                Navigator.pushNamed(context, AlertsScreen.id);
              },
            ),
            ListTile(
              title: Text('Messages'),
              leading: Icon(Icons.chat),
            ),
            ListTile(
              title: Text('My Services'),
              leading: Icon(Icons.dashboard),
              onTap: (){
                Navigator.pushNamed(context, MyServices.id);
              },
            ),
            ListTile(
              title: Text('My Bids'),
              leading: Icon(Icons.payment),
              onTap: (){
                Navigator.pushNamed(context, Bids.id);
              },
            ),
            ListTile(
              title: Text('Stats'),
              leading: Icon(Icons.grade),
            ),
            ListTile(
              title: Text('Help'),
              leading: Icon(Icons.help),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: kRedAlert,
                  onPressed: () {
                    print('Log user out');
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: _screens[
          _selectedIndex], //body will be whatever screen is represented by the index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kScaffoldBackgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
