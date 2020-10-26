import 'package:flutter/material.dart';
import 'package:servio/constants.dart';

class BasicStats extends StatelessWidget {
  final String item;
  final String value;

  BasicStats({@required this.item, @required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(kMainHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  item,
                  style: kHeadingTextStyle,
                ),
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 32.0,
                  backgroundColor: kPrimaryColor,
                  child: Center(
                    child: Text(
                      value,
                      style: kTestTextStyleWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
