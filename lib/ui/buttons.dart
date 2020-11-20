import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  AuthButton({Key key, @required this.onPressed, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Theme.of(context).accentColor,
      child: child,
      onPressed: onPressed,
    );
  }
}
