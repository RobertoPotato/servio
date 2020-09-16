import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final String token;

  FavoritesScreen({@required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('You currently have no favorites. Add some'),
            ),
          ],
        ),
      ),
    );
  }
}
