import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Edit Photo"),
              Text("Edit Phone Number"),
              Text("Edit Bio"),
              FlatButton(
                onPressed: () {
                  print("Update Profile");
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
