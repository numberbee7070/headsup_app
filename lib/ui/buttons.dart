import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  AuthButton({Key key, @required this.onPressed, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSurface: Theme.of(context).accentColor,
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
