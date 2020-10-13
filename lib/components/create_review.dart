import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/constants.dart';

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

  sendReview() {
    print("Review has been sent");
  }

  @override
  Widget build(BuildContext context) {
    print(sliderValue);
    return Container(
      width: 300.0,
      height: 400.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${widget.name}"),
                Icon(Icons.close),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Slider(
                    activeColor: kPrimaryColor,
                    min: 0,
                    max: 5,
                    value: sliderValue,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                    divisions: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(iconToSHow(sliderValue), size: 38.0,),
                  ), //TODO use function that changes emoji based on value of rating given
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

iconColor(double val){
  if (val< )
}
