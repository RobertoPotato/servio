import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  static String id = 'alerts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('Seems you\'re all caught up'),
            ),
          ],
        ),
      ),
    );
  }
}
