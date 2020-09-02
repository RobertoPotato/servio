import 'package:flutter/material.dart';

class BasicProfilePopup extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final bool isVerified;
  final String avatar;

  const BasicProfilePopup(
      {@required this.name,
      @required this.phoneNumber,
      @required this.isVerified,
      @required this.avatar});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$name"),
        Text("phone Number: $phoneNumber"),
        Text("avatar of the user: $avatar"),
        Text("User is verified?: $isVerified"),
      ],
    );
  }
}
