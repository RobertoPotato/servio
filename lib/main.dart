import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id : (context)=>HomeScreen(),
        RegisterScreen.id : (context)=>RegisterScreen(),
        LoginScreen.id : (context)=>LoginScreen(),
      },
    );
  }
}

