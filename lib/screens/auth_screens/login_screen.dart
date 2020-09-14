import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordsMatch;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  logInUser(
    String email,
    String password,
  ) {
    print("$email $password is logged in");
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
                    validators: [FormBuilderValidators.required(), FormBuilderValidators.minLength(8)],
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                if (_fbKey.currentState.saveAndValidate()) {
                  final formData = _fbKey.currentState.value;
                  final email = formData['email'].toString().trim();
                  final password = formData['password'].toString().trim();
                  logInUser(email, password);
                }
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
