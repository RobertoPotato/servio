import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/parent_screen.dart';
import 'constants.dart';
import 'screens/request_service.dart';
import 'screens/bid_screen.dart';
import 'screens/alerts_details_screens/bid_detail.dart';

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
      initialRoute: MainParentScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainParentScreen.id: (context) => MainParentScreen(),
        RequestServicePage.id : (context) => RequestServicePage(),
        BidScreen.id : (context) => BidScreen(),
        BidDetails.id : (context) => BidDetails(),
      },
    );
  }
}
