import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';
import 'services/service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String _username;

  String _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/login_page.png"),
          Text(
            "Heads Up",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 0.2, //extend the shadow
                  offset: Offset(
                    0, // Move to right 10  horizontally
                    8.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: TextFormField(
              cursorColor: Theme.of(context).accentColor,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String text) => _username = text,
              decoration: InputDecoration(
                hintText: AutofillHints.username,
                prefixIcon: Icon(Icons.perm_identity),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0, // soften the shadow
                  spreadRadius: 0.2, //extend the shadow
                  offset: Offset(
                    0, // Move to right 10  horizontally
                    8.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: TextFormField(
              cursorColor: Theme.of(context).primaryColor,
              obscureText: true,
              onSaved: (String text) => _password = text,
              decoration: InputDecoration(
                hintText: AutofillHints.password,
                prefixIcon: Icon(Icons.lock),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.pink[200],
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                try {
                  await AuthServices.emailSignIn(_username, _password);
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(e.message),
                  ));
                }
              }
            },
          )
        ],
      ),
    );
  }
}
