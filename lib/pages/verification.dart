import 'package:app/auth/services/service.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Please verify your email to continue. Once done click the button below.",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
              RaisedButton(
                  child: Text("Logout"),
                  onPressed: () async {
                    await AuthServices.logout();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
