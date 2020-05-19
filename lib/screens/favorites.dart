import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  static String id = 'favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Your favorites Here'),
          ],
        ),
      ),
    );
  }
}
