import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final double borderRadius;
  final double elevation;
  final String imageUrl;
  final bool isNetworkImage;
  final double height;
  final double width;
  final double bottomLeftRad;
  final double bottomRightRad;

  ImageContainer({
    @required this.borderRadius,
    @required this.elevation,
    @required this.imageUrl,
    @required this.isNetworkImage,
    @required this.height,
    this.width,
    this.bottomLeftRad,
    this.bottomRightRad
  });

  double getBottomRadius(double radValue, double radius){
    if ( radValue != null && radValue > 0 ){
      return radValue;
    } else {
      return radius;
    }
  }

  double getTopRadius(double radValue, double radius){
    if ( radValue != null && radValue > 0 ){
      return 0.0;
    } else {
      return radius;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getTopRadius(bottomLeftRad, borderRadius)),
          topRight: Radius.circular(getTopRadius(bottomRightRad, borderRadius)),
          bottomLeft: Radius.circular(getBottomRadius(bottomLeftRad, borderRadius)),
          bottomRight: Radius.circular(getBottomRadius(bottomRightRad, borderRadius))
      ),
      elevation: elevation,
      child: Container(
        height: height,
        width: width == null ? double.infinity : width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(getTopRadius(bottomLeftRad, borderRadius)),
              topRight: Radius.circular(getTopRadius(bottomRightRad, borderRadius)),
              bottomLeft: Radius.circular(getBottomRadius(bottomLeftRad, borderRadius)),
              bottomRight: Radius.circular(getBottomRadius(bottomRightRad, borderRadius))),
        ),
      ),
    );
  }
}

//pass in the main radius to use or pass in the individual radii to use
//give precedence to mainRadius ie should be the required
