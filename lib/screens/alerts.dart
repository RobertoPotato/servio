import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  static String id = 'alerts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Your notifications Here'),
          ],
        ),
      ),
    );
  }
}
