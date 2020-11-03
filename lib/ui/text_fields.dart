import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final Widget prefixIcon;
  final Function validator;

  AuthTextField({
    @required this.controller,
    @required this.hintText,
    @required this.prefixIcon,
    this.validator,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
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
        validator: this.validator,
        controller: controller,
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
