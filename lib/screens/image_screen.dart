import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:servio/constants.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({@required this.imageUrl, @required this.isNetworkImage});
  final imageUrl;
  final isNetworkImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: PhotoView(
            imageProvider:
                isNetworkImage ? NetworkImage(imageUrl) : AssetImage(imageUrl),
            loadFailedChild: Center(
              child: Text(
                "Loading image failed",
                style: kTestTextStyleWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
