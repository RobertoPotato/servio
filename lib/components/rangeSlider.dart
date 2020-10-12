import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class CustomSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final bool hasDivisions;
  final int divisions;

  const CustomSlider(
      {@required this.minValue,
      @required this.maxValue,
      @required this.hasDivisions,
      this.divisions});
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  var sliderValue;

  @override
  Widget build(BuildContext context) {
    print(sliderValue);
    return Slider(
      value: sliderValue,
      onChanged: (value) {
        setState(() {
          sliderValue = value;
        });
      },
      activeColor: kPrimaryColor,
      inactiveColor: Colors.grey[600],
      min: widget.minValue,
      max: widget.maxValue,
      label: "Hi",
      divisions: widget.hasDivisions ? widget.divisions : null,
    );
  }
}
