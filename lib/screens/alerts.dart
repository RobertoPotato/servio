import 'package:flutter/material.dart';
/*
* This page will show alerts (jobs that have been posted)
* in a particular category that a certain user has been
* subscribed to.
* jobs.categories == agent.skill*/
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
