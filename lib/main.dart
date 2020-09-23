import 'package:flutter/material.dart';
import 'screens/auth_screens/register_screen.dart';
import 'screens/auth_screens/login_screen.dart';
import 'screens/parent_screen.dart';
import 'constants.dart';
import 'screens/service_screens/request_service.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screens/new_profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'jwt_helpers.dart';

final storage = FlutterSecureStorage();

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
      home: FutureBuilder(
        future: jwtOrEmpty,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(kMainHorizontalPadding),
                child: CircularProgressIndicator(
                  semanticsLabel: "Loading...",
                ),
              ),
            );
          if (snapshot.data != '') {
            return verifyToken(snapshot.data) ? MainParentScreen() : LoginScreen();
          } else
            return LoginScreen();
        },
      ),
      routes: {
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        NewProfile.id: (context) => NewProfile(),
        MainParentScreen.id: (context) => MainParentScreen(),
        RequestServicePage.id: (context) => RequestServicePage(),
        SettingsScreen.id: (context) => SettingsScreen(),
      },
    );
  }
}