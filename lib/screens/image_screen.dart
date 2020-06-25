import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({this.imageUrl});
  final imageUrl;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(image: NetworkImage(imageUrl),),
        ),
      ),
    );
  }
}
