import 'dart:io';

import 'package:flutter/material.dart';

import '../model/exceptions.dart';
import '../ui/buttons.dart';
import '../ui/text_fields.dart';
import 'services/service.dart';

class SetProfile extends StatefulWidget {
  @override
  _SetProfileState createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  TextEditingController usernameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: FutureBuilder<bool>(
            future: AuthServices.isVerified,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("enter a username for your account"),
                      AuthTextField(
                        controller: usernameController,
                        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                        hintText: 'new username',
                        autofillHints: [AutofillHints.newUsername],
                      ),
                      SizedBox(height: 20.0),
                      AuthButton(
                        onPressed: () async {
                          this._scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Row(
                                  children: [
                                    Text("Updating profile"),
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ));
                          try {
                            await AuthServices.newSignUp(
                                this.usernameController.text);
                          } on SocketException {
                            this._scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Network error. Try again later")));
                            return;
                          } on HttpServerError {
                            this._scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Server error. Try again later")));
                            return;
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Your Email Address is not verified please click verification link in email.",
                        textAlign: TextAlign.center,
                      ),
                      AuthButton(
                          child: Text("Recheck"),
                          onPressed: () => this.setState(() {}))
                    ],
                  );
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
