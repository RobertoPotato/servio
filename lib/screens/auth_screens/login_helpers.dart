import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/screens/parent_screen.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/ErrorResponse.dart';

const storage = FlutterSecureStorage();


getProfile(String token, ctxt) async {
  final String url = "$kBaseUrl/v1/profiles/validate";

  final response = await http.get(Uri.encodeFull(url), headers: {
    "accept": "application/json",
    "content-type": "application/json",
    "x-auth-token": token
  });

  if (response.statusCode == 200) {
    await storage.write(key: "profile", value: 'OK').then(
          (value) => Navigator.pushNamedAndRemoveUntil(
          ctxt, MainParentScreen.id, (route) => false),
    );
  } else if (response.statusCode == 404) {
    var error = errorFromJson(response.body);

    showDialog(
      context: ctxt,
      builder: (ctxt) => AlertDialog(
        title: Text("Alert!"),
        content: Text(error.error),
        actions: [
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                ctxt, MainParentScreen.id, (route) => false),
          ),
        ],
      ),
    );
  } else {
    displayDialog(
        ctxt, "No profile yet", "You should set it up once logged in");
  }
}