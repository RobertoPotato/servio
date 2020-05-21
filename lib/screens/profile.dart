import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('Your profile Here'),
            ),
          ],
        ),
      ),
    );
  }
}
