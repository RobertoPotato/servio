import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Home screen'),
          ],
        ),
      ),
    );
  }
}
