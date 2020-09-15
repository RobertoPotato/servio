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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;

final storage = FlutterSecureStorage();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "x-auth-token");
    if (jwt == null) return '';
    return jwt;
  }

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
          if (!snapshot.hasData) return CircularProgressIndicator();
          if (snapshot.data != '') {
            var str = snapshot.data;
            var jwt = str.split(".");

            if (jwt.length != 3) {
              return LoginScreen();
            } else {
              //decode the jwt value at array index 1 => contains the payload
              var payload = json.decode(
                ascii.decode(
                  base64.decode(
                    base64.normalize(jwt[1]),
                  ),
                ),
              );
              if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                  .isAfter(
                DateTime.now(),
              )) {
                return MainParentScreen();
              } else {
                return LoginScreen();
              }
            }
          } else
            return LoginScreen();
        },
      ),
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainParentScreen.id: (context) => MainParentScreen(),
        RequestServicePage.id: (context) => RequestServicePage(),
        SettingsScreen.id: (context) => SettingsScreen(),
        FavoritesScreen.id: (context) => FavoritesScreen(),
        MyServices.id: (context) => MyServices(),
      },
    );
  }
}
