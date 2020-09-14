import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/auth_screens/register_screen.dart';
import 'screens/auth_screens/login_screen.dart';
import 'screens/parent_screen.dart';
import 'constants.dart';
import 'screens/service_screens/request_service.dart';
import 'screens/settings_screen.dart';
import 'screens/favorites.dart';
import 'screens/service_screens/my_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),

      //todo change initial route back to MainParentScreen.id
      initialRoute: RegisterScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainParentScreen.id: (context) => MainParentScreen(),
        RequestServicePage.id: (context) => RequestServicePage(),
        SettingsScreen.id: (context) => SettingsScreen(),
        FavoritesScreen.id :  (context) => FavoritesScreen(),
        MyServices.id : (context) => MyServices(),
      },
    );
  }
}
