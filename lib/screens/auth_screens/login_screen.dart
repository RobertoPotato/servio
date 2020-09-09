import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Log in Here'),
          ],
        ),
      ),
    );
  }
}
