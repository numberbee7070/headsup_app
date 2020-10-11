import 'package:app/auth/signup.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _register = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.pink[200],
                Colors.pink[300],
                Colors.pink[400],
              ],
              stops: [
                0.0,
                0.3,
                0.9,
              ]),
        ),
        child: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    "Heads Up!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  _register ? signUpForm(context) : loginForm(context),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(_register ? "Already Registered" : "New User"),
                    onPressed: () =>
                        this.setState(() => _register = !_register),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Divider(endIndent: 10.0)),
                      Text("OR"),
                      Expanded(child: Divider(indent: 10.0)),
                    ],
                  ),
                  RaisedButton.icon(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "oauth"),
                    icon: Icon(Icons.mail_outline),
                    label: Text(_register
                        ? "Sign Up with google"
                        : "sign in with google"),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
