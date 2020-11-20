import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final Widget prefixIcon;
  final Function validator;

  AuthTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.prefixIcon,
    this.validator,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: TextFormField(
        validator: this.validator,
        controller: controller,
        obscureText: obscure,
        cursorColor: Theme.of(context).accentColor,
        keyboardType: this.obscure
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: this.hintText,
          prefixIcon: this.prefixIcon,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
