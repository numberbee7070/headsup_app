import 'package:app/auth/services/google_oauth.dart';
import 'package:app/auth/signup.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _register = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  _register ? signUpForm(context) : LoginForm(),
                  FlatButton(
                    child: Text(
                        _register ? "Already Registered? Login" : "New User"),
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
                  RaisedButton(
                    child: Text("sign in with google"),
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
                  RaisedButton(
                    child: Text("Sign in with phone no."),
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
