import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

var parser = EmojiParser();

class CreateReview extends StatefulWidget {
  final token;
  final int clientOrAgentId;
  final String name;

  const CreateReview(
      {@required this.token,
      @required this.clientOrAgentId,
      this.name}); //recipient of the review
  @override
  _CreateReviewState createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  double sliderValue = 2.5;
  var min = 0.0;
  var max = 5.0;
  var divisions = 50;

  sendReview() {
    print("Review has been sent");
  }

  @override
  Widget build(BuildContext context) {

    print(sliderValue);
    return Container(
      width: 300.0,
      height: 350.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:kMainHorizontalPadding, right: kMainHorizontalPadding, bottom: kMainHorizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${widget.name}", style: kHeadingTextStyle,),
                  Text("${emojiToShow(sliderValue)}", style: TextStyle(fontSize: 30.0),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:kMainHorizontalPadding, right: kMainHorizontalPadding, bottom: kMainHorizontalPadding),
              child: Column(
                children: [
                  Slider(
                    label: sliderValue.toStringAsFixed(1),
                    activeColor: kPrimaryColor,
                    min: min,
                    max: max,
                    value: sliderValue,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                    divisions: divisions,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Rated: ${sliderValue.toStringAsFixed(1)}', style: kHeadingSubTextStyle,),
                  ),
                  FormBuilderTextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    attribute: 'reviewText',
                  )
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                sendReview();
              },
              color: kPrimaryColor,
              child: Text(
                "Send",
                style: kTestTextStyleWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}

IconData iconToSHow(double val){
  if(val <= 1) {
    return Icons.sentiment_very_dissatisfied;
  } else if (val <= 2){
    return Icons.sentiment_dissatisfied;
  } else if (val <= 3){
    return Icons.sentiment_neutral;
  } else if (val <= 4){
    return Icons.sentiment_satisfied;
  } else if (val <= 5){
    return Icons.sentiment_very_satisfied;
  } else return Icons.error;
}

emojiToShow(double val){
  var verySatisfied = '😀';
  var satisfied = '😊';
  var neutral = '😐';
  var dissatisfied = '😧';
  var veryDissatisfied = '😣';

  if(val <= 1) {
    return veryDissatisfied;
  } else if (val <= 2){
    return dissatisfied;
  } else if (val <= 3){
    return neutral;
  } else if (val <= 4){
    return satisfied;
  } else if (val <= 5){
    return verySatisfied;
  } else return Icons.error;
}

Color iconColor(double val){
  if (val<= 2){
    return Colors.redAccent;
  } else if (val <= 3.5) {
    return Colors.orangeAccent;
  } else if (val <= 5) {
    return Colors.greenAccent;
  } else return Colors.grey[600];
}
