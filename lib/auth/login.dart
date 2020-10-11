import 'package:flutter/material.dart';
import 'package:app/model/model.dart';

Widget loginForm(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
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
              onSaved: (String text) => _username = text,
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
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Model.newLogin(_username, _password)
                    .then(
                  (_) => Navigator.pushReplacementNamed(context, "home"),
                )
                    .catchError(
                  (e) {
                    print("login error: " + e.toString());
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Can not login")),
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    ),
  );
}
