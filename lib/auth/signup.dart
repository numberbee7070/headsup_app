import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ui/text_fields.dart';
import 'services/service.dart';

class SignUpForm extends StatefulWidget {
  final Function signUpCallBack;
  SignUpForm({Key key, this.signUpCallBack}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthTextField(
            controller: this.emailController,
            hintText: AutofillHints.email,
            prefixIcon: Icon(Icons.account_circle),
          ),
          SizedBox(
            height: 20,
          ),
          AuthTextField(
            controller: passwordController,
            prefixIcon: Icon(Icons.lock),
            hintText: AutofillHints.password,
            obscure: true,
            validator: (text) =>
                (text.trim().length >= 8) ? null : "enter minimum 8 characters",
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
                  await AuthServices.emailSignUp(
                      this.emailController.text, this.passwordController.text);

                  // Navigator.pushReplacementNamed(context, HomePage.routeName);
                  widget.signUpCallBack();
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
    );
  }
}
