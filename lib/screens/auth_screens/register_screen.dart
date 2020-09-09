import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Register Here'),
          ],
        ),
      ),
    );
  }
}
