import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';
import 'services/service.dart';

Widget signUpForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String _username, _password, _email;
  return Builder(
    builder: (context) => Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink[700],
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
              onSaved: (value) => _username = value,
              decoration: InputDecoration(
                hintText: AutofillHints.username,
                prefixIcon: Icon(Icons.account_circle),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink[700],
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
              onSaved: (value) => _email = value,
              decoration: InputDecoration(
                hintText: AutofillHints.email,
                prefixIcon: Icon(Icons.email),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink[700],
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
              onSaved: (value) => _password = value,
              decoration: InputDecoration(
                hintText: AutofillHints.password,
                prefixIcon: Icon(Icons.lock),
                border: InputBorder.none,
              ),
              validator: (text) => (text.trim().length >= 8)
                  ? null
                  : "enter minimum 8 characters",
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
              "SIGN UP",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                try {
                  await AuthServices.emailSignUp(_email, _username, _password);
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                } on FirebaseAuthException catch (e) {
                  String msg = e.message;
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(msg)));
                }
              }
            },
          ),
        ],
      ),
    ),
  );
}
