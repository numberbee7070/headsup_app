import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  child: TextField(
                    cursorColor: Theme.of(context).accentColor,
                    keyboardType: TextInputType.emailAddress,
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
                  child: TextField(
                    cursorColor: Theme.of(context).primaryColor,
                    obscureText: true,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.pink[200],
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
