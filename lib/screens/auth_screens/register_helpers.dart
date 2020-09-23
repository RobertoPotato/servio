import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
Future registerUser(
    String firstName,
    String lastName,
    String email,
    String password,
    ) async {
  print("$firstName $lastName is registered");
  final String url = "$kBaseUrl/v1/auth/register";
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
      });
  if(response.statusCode == 200) {
    print(response.body);
  } else {
    print("Request failed");
  }
}
