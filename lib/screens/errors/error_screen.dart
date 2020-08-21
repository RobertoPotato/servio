import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class Error extends StatelessWidget {
  final String message;
  final String errorImage;

  Error({@required this.message, @required this.errorImage});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(errorImage),
          Text(message, style: kTestTextStyleBlack,),
          FlatButton(
            color: kRedAlert,
            textColor: Colors.white,
            onPressed: (){
              Navigator.pop(context);
            }, child: Text("Go Back", style: kTestTextStyleWhite,),
          )
        ],
      ),
    );
  }
}
