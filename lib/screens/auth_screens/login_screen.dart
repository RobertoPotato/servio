import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:servio/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:servio/screens/auth_screens/register_screen.dart';
import 'package:servio/jwt_helpers.dart';
import 'package:servio/models/ErrorResponse.dart';
import 'login_helpers.dart';

final storage = FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordsMatch;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future profile;

  Future<String> logInUser({String email, String password, ctxt}) async {
    print(kBaseUrl);
    final String url = "$kBaseUrl/v1/auth/login";
    try {
      final response = await http.post(Uri.encodeFull(url),
          body: json.encode({"email": email, "password": password}),
          headers: {
            "accept": "application/json",
            "content-type": "application/json"
          }).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 404) {
        var error = errorFromJson(response.body);
        displayResponseCard(
            ctxt, kUniversalErrorTitle, error.error, kErrorImage);
        return error.error;
      } else if (response.statusCode == 400) {
        var error = errorFromJson(response.body);
        displayResponseCard(
            ctxt, kUniversalErrorTitle, error.error, kErrorImage);
        return error.error;
      }
    } on TimeoutException catch (e) {
      print(e.message);
      displayResponseCard(context, 'Error', 'Request timed out', kErrorImage);
    } on SocketException catch (e) {
      print(e.message);
      displayResponseCard(context, "Error", "No connection to the server", kErrorImage);
    }
    //FIXME
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/icon.png",
              height: 220.0,
              width: 220.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kMainHorizontalPadding,
                  vertical: kMainHorizontalPadding / 2),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      attribute: 'email',
                      decoration: InputDecoration().copyWith(
                        hintText: 'Email',
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FormBuilderTextField(
                      keyboardType: TextInputType.visiblePassword,
                      attribute: 'password',
                      obscureText: true,
                      obscuringCharacter: "\$",
                      decoration: InputDecoration().copyWith(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.security),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              color: kPrimaryColor,
              onPressed: () async {
                if (_fbKey.currentState.saveAndValidate()) {
                  final formData = _fbKey.currentState.value;
                  final email = formData['email'].toString().trim();
                  final password = formData['password'].toString().trim();

                  var jwt = await logInUser(
                      email: email, password: password, ctxt: context);
                  if (jwt != null) {
                    await storage
                        .write(key: "x-auth-token", value: jwt)
                        .then((value) => getProfile(jwt, context)
                            //Navigator.pushNamed(context, MainParentScreen.id),
                            );
                  }
                }
              },
              child: Text(
                'Log In',
                style: kTestTextStyleWhite,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: Text(
                  "Not yet registered? Register now",
                  style: TextStyle(color: Colors.grey[900], fontSize: 16.0),
                )),
          ],
        ),
      ),
    );
  }
}
