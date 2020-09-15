import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/screens/auth_screens/register_screen.dart';
import 'package:servio/screens/parent_screen.dart';

final storage = FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();

  void displayDialog(ctxt, title, text) => showDialog(
        context: ctxt,
        builder: (ctxt) => AlertDialog(
          title: Text(title),
          content: Text(text),
        ),
      );
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordsMatch;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<String> logInUser(
    String email,
    String password,
  ) async {
    final String url = "$kBaseUrl/v1/auth/login";
    final response = await http.post(Uri.encodeFull(url),
        body: json.encode({"email": email, "password": password}),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    attribute: 'email',
                    decoration: InputDecoration().copyWith(
                      hintText: 'Email',
                      labelText: 'Email',
                      //prefixIcon: Icon(Icons.work),
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email()
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'password',
                    decoration: InputDecoration().copyWith(
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.security),
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8)
                    ],
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () async {
                if (_fbKey.currentState.saveAndValidate()) {
                  final formData = _fbKey.currentState.value;
                  final email = formData['email'].toString().trim();
                  final password = formData['password'].toString().trim();

                  // Check if user has a profile
                  //If not, go to create profile screen
                  //If user has profile, fetch the profile and save it. On completion, go to main screen
                  var jwt = await logInUser(email, password);
                  if (jwt != null) {
                    storage.write(key: "x-auth-token", value: jwt);
                    Navigator.pushNamed(context, MainParentScreen.id);
                  }
                }
              },
              child: Text('Log In'),
            ),
            GestureDetector(onTap: (){
              Navigator.pushNamed(context, RegisterScreen.id);
            }  ,child: Text("Not yet registered? Register now")),
          ],
        ),
      ),
    );
  }
}
