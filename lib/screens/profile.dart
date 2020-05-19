import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Your profile Here'),
          ],
        ),
      ),
    );
  }
}
