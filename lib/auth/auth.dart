import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import '../pages/home.dart';
import '../ui/phone_login_button.dart';
import 'login.dart';
import 'phone_auth.dart';
import 'services/google_oauth.dart';
import 'signup.dart';

class AuthForm extends StatefulWidget {
  static String routeName = "auth";
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _register = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.083 * size.width,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _register ? SignUpForm() : LoginForm(),
              TextButton(
                child: Text(
                  _register ? "Already Registered? Login" : "New? Sign Up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => this.setState(() => _register = !_register),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Divider(endIndent: 10.0)),
                  Text("OR"),
                  Expanded(child: Divider(indent: 10.0)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _register ? 'Sign up with' : 'Sign in with',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GoogleSignInButton(
                    text: 'Google',
                    // _register ? 'Sign up with Google' : 'Sign in with Google',
                    onPressed: () async {
                      try {
                        await signInWithGoogle();
                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
                      } catch (e) {
                        print("google sign in error ${e.toString()}");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Cant login"),
                        ));
                      }
                    },
                  ),
                  PhoneLoginButton(
                      text: 'Phone',
                      // _register ? 'Sign up with Phone' : 'Sign in with Phone',
                      onPressed: () =>
                          Navigator.pushNamed(context, PhoneAuth.routeName)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
