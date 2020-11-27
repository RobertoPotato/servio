import 'package:flutter/material.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/constants.dart';

//TODO Use media queries here to determine appropriate height and width of the widget

class HelpCards extends StatelessWidget {
  final String title;
  final String image;
  final content; //This can be a video, gif, or document

  const HelpCards(
      {@required this.title, @required this.image, @required this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMainHorizontalPadding + 2),
      child: Container(
        child: Column(
          children: [
            ImageContainer(borderRadius: 10.0, elevation: 5.0, imageUrl: "images/Alien-Butt.gif", isNetworkImage: false, height: 250, width: 175.0,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(title.toUpperCase(), style: TextStyle(color: Colors.grey[700], ),),
            )
          ],
        ),
      ),
    );
  }
}
