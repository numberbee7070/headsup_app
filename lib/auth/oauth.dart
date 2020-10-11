import 'package:app/model/google_oauth.dart';
import 'package:flutter/material.dart';

class OauthForm extends StatefulWidget {
  @override
  _OauthFormState createState() => _OauthFormState();
}

class _OauthFormState extends State<OauthForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.pink,
        ),
        child: SafeArea(
          child: FutureBuilder(
            future: GoogleOAuthHelper.getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Container(
                    color: Colors.white,
                    child: Text("Error occurred"),
                  );
                }
                print(snapshot.data);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
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
                      RaisedButton(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, "home"),
                        child: Text("Login"),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
