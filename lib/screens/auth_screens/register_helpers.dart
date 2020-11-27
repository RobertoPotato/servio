import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'package:servio/screens/auth_screens/login_screen.dart';

//Which icons to show
Icon iconToShow(testCase) {
  if (testCase == null) {
    return Icon(
      Icons.check_box_outline_blank,
      color: kPrimaryColor,
    );
  } else if (testCase == true) {
    return Icon(
      Icons.check,
      color: kMyBidsColor,
    );
  } else {
    return Icon(
      Icons.warning,
      color: kMySettingsColor,
    );
  }
}

//Post the data
Future registerUser(String firstName, String lastName, String email,
    String password, ctxt) async {
  print("$firstName $lastName is registered");
  final String url = "$kBaseUrl/v1/auth/register";
  try {
    final response = await http.post(Uri.encodeFull(url),
        body: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        }).timeout(Duration(seconds: kNetworkRequestTimeOutDuration));
    if (response.statusCode == 200) {
      Navigator.pushNamed(ctxt, LoginScreen.id);
    } else if (response.statusCode == 400) {
      var error = errorFromJson(response.body);
      displayResponseCard(ctxt, kUniversalErrorTitle, error.error, kErrorImage);
    } else {
      displayResponseCard(
          ctxt, kUniversalErrorTitle, kSomethingWrongException, kErrorImage);
    }
  } on SocketException catch (e) {
    print(e.message);
    displayResponseCard(ctxt, "Error", kNoConnection, kErrorImage);
  } on TimeoutException catch (e) {
    print(e.message);
    displayResponseCard(ctxt, "Error", kRequestTimedOut, kErrorImage);
  }
}
