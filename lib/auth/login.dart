import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../ui/buttons.dart';
import '../ui/text_fields.dart';
import 'services/service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Size size;

  @override
  void dispose() {
    this.emailController.dispose();
    this.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/login_page.png"),
          Image.asset("assets/images/logo.png"),
          AuthTextField(
            controller: emailController,
            prefixIcon: Icon(Icons.perm_identity),
            hintText: 'email',
            autofillHints: [AutofillHints.email],
          ),
          AuthTextField(
            controller: passwordController,
            prefixIcon: Icon(Icons.lock),
            hintText: 'password',
            autofillHints: [AutofillHints.password],
            obscure: true,
          ),
          SizedBox(
            height: 0.015 * size.height,
          ),
          AuthButton(
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  await AuthServices.emailSignIn(
                    this.emailController.text,
                    this.passwordController.text,
                  );
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
