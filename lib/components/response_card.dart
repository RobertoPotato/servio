/*
* A better-looking way to show http and other response
* information eg errors and alerts and warnings*/
import 'package:flutter/material.dart';
import 'package:servio/components/material_text.dart';
import 'package:servio/constants.dart';

class ResponseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String text;

  const ResponseCard({this.imageUrl, this.title, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  top: 0.0,
                  height: 240.0,
                ),
                Positioned(
                  top: 200.0,
                  child: MaterialText(
                    text: title,
                    color: kPrimaryColor,
                    fontStyle: kTestTextStyleWhite,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                text,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*Expanded(
            flex: 2,
            child: Image.asset('name'),
          ),
          Expanded(
            flex: 1,
            child: Text("Text"),
          ),*/
