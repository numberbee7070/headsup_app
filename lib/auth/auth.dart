import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import '../ui/phone_login_button.dart';
import 'login.dart';
import 'services/google_oauth.dart';
import 'signup.dart';

class AuthForm extends StatefulWidget {
  static String routeName = "auth";
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _register = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  _register ? signUpForm(context) : LoginForm(),
                  FlatButton(
                    child: Text(_register
                        ? "Already Registered? Login"
                        : "New? Sign Up"),
                    onPressed: () =>
                        this.setState(() => _register = !_register),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider(endIndent: 10.0)),
                      Text("OR"),
                      Expanded(child: Divider(indent: 10.0)),
                    ],
                  ),
                  GoogleSignInButton(
                    onPressed: () async {
                      try {
                        await signInWithGoogle();
                      } catch (e) {
                        print("Error: ${e.toString()}");
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Cant login"),
                        ));
                      }
                      Navigator.pushReplacementNamed(context, "home");
                    },
                  ),
                  PhoneLoginButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "phone_auth"),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
