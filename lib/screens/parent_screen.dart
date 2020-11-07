import 'package:flutter/material.dart';
import 'package:servio/screens/errors/error_screen.dart';
import 'package:servio/screens/home_screen.dart';
import 'package:servio/constants.dart';
import 'package:servio/screens/categories.dart';
import 'package:servio/screens/bids_screens/bids.dart';
import 'package:servio/screens/job_screens/job_parent_screen.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/screens/profile_screens/profile_helpers.dart';
import 'package:servio/screens/service_screens/my_services.dart';
import 'package:servio/screens/settings_screen.dart';
import 'package:servio/screens/stats_screen.dart';

class MainParentScreen extends StatefulWidget {
  static String id = 'parentScreen';

  @override
  _MainParentScreenState createState() => _MainParentScreenState();
}

class _MainParentScreenState extends State<MainParentScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: jwtOrEmpty,
      builder: (context, jwtSnapshot) {
        return FutureBuilder(
          future: profileOrEmpty,
          builder: (context, profileSnapshot) {
            if (!jwtSnapshot.hasData)
              return Center(child: CircularProgressIndicator());
            if (jwtSnapshot.data != "") {
              return Scaffold(
                drawer: Container(
                  color: Colors.white, //Background for sidebar
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
                                      image:
                                          AssetImage("images/Alien-Butt.gif"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('Profile'),
                          leading: Icon(
                            Icons.person,
                            color: Colors.teal,
                          ),
                          trailing: profileSnapshot.data != ''
                              ? Text('')
                              : Icon(
                                  Icons.error,
                                  color: kRedAlert,
                                ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    profileOrNewProfile(
                                        jwtSnapshot.data, profileSnapshot.data),
                              ),
                            );
                          },
                        ),
                        /*
                        ListTile(
                          title: Text('Favorites(Coming Soon)'),
                          leading: Icon(
                            Icons.favorite,
                            color: kRedAlert,
                          ),
                          trailing: Icon(Icons.timer),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FavoritesScreen(
                                  token: jwtSnapshot.data,
                                ),
                              ),
                            );
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
                        */
                        ListTile(
                          title: Text('My Services'),
                          leading:
                              Icon(Icons.dashboard, color: Colors.redAccent),
                          onTap: () {
                            //MyServices
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => MyServices(
                                  token: jwtSnapshot.data,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text('My Bids'),
                          leading:
                              Icon(Icons.payment, color: Colors.greenAccent),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Bids(
                                  token: jwtSnapshot.data,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text('Jobs'),
                          leading: Icon(Icons.work, color: Colors.purple),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    JobParentScreen(
                                  token: jwtSnapshot.data,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text('Stats'),
                          leading:
                              Icon(Icons.grade, color: Colors.lightBlueAccent),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    StatsPage(
                                      token: jwtSnapshot.data,
                                    ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text('Help(Coming soon)'),
                          trailing: Icon(Icons.timer),
                          leading: Icon(Icons.help, color: kPrimaryColor),
                        ),

                        ListTile(
                          title: Text('Settings'),
                          leading: Icon(Icons.settings, color: Colors.blueGrey),
                          onTap: () {
                            Navigator.pushNamed(context, SettingsScreen.id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                //body will be whatever screen is represented by the index and the
                //token contained in snapshot.data
                body: _selectedIndex == 0
                    ? HomeScreen(
                        token: jwtSnapshot.data,
                      )
                    : Categories(
                        token: jwtSnapshot.data,
                      ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: kPrimaryColor,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.category),
                      label: 'Categories',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: kScaffoldBackgroundColor,
                  onTap: _onItemTapped,
                ),
              );
            } else {
              return ErrorScreen(
                message: "Invalid Token",
                errorImage: kErrorImage,
              );
            }
          },
        );
      },
    );
  }
}
