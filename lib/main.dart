import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/parent_screen.dart';
import 'constants.dart';
import 'screens/request_service.dart';
import 'screens/settings_screen.dart';
import 'screens/alerts_details_screens/info_detail.dart';
import 'screens/profile.dart';
import 'screens/favorites.dart';
import 'screens/alerts.dart';
import 'screens/bids.dart';
import 'screens/my_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        //canvasColor: Colors.transparent,
        accentColor: kAccentColor,
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),

      //todo change initial route back to MainParentScreen.id
      initialRoute: MainParentScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainParentScreen.id: (context) => MainParentScreen(),
        RequestServicePage.id: (context) => RequestServicePage(),
        SettingsScreen.id: (context) => SettingsScreen(),
        InfoDetailsScreen.id: (context) => InfoDetailsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        FavoritesScreen.id :  (context) => FavoritesScreen(),
        AlertsScreen.id : (context) => AlertsScreen(),
        Bids.id : (context) => Bids(),
        MyServices.id : (context) => MyServices(),
      },
    );
  }
}
