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
      drawer: Container(
        color: Colors.white, //TODO Background for sidebar
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 250.0,
                child: DrawerHeader(
                  //images/Alien-Butt.gif
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/Alien-Butt.gif"),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Profile'),
                leading: Icon(
                  Icons.person,
                  color: Colors.teal,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ProfileScreen(
                        userId: kUserId,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Favorites(Coming Soon)'),
                leading: Icon(
                  Icons.favorite,
                  color: kRedAlert,
                ),
                trailing: Icon(Icons.timer),
                onTap: () {
                  Navigator.pushNamed(context, FavoritesScreen.id);
                },
              ),
              ListTile(
                title: Text('Alerts(Coming Soon)'),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.blueAccent,
                ),
                trailing: Icon(Icons.timer),
                onTap: () {
                  Navigator.pushNamed(context, AlertsScreen.id);
                },
              ),
              ListTile(
                title: Text('Messages(Coming Soon)'),
                leading: Icon(
                  Icons.chat,
                  color: Colors.tealAccent,
                ),
                trailing: Icon(Icons.timer),
              ),
              ListTile(
                title: Text('My Services'),
                leading: Icon(Icons.dashboard, color: Colors.redAccent),
                onTap: () {
                  Navigator.pushNamed(context, MyServices.id);
                },
              ),
              ListTile(
                title: Text('My Bids'),
                leading: Icon(Icons.payment, color: Colors.greenAccent),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Bids(userId: kUserId,),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Stats(Coming Soon)'),
                leading: Icon(Icons.grade, color: Colors.lightBlueAccent),
                trailing: Icon(Icons.timer),
              ),
              ListTile(
                title: Text('Help'),
                leading: Icon(Icons.help, color: kPrimaryColor),
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blueGrey),
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
