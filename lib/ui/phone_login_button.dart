import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_auth_buttons/src/button.dart';

class PhoneLoginButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final bool darkMode;
  final double borderRadius;
  final VoidCallback onPressed;
  final Color splashColor;
  final bool centered;

  PhoneLoginButton(
      {this.onPressed,
      this.text = 'Sign in with Phone',
      this.textStyle,
      this.splashColor,
      this.darkMode = false,
      // Google doesn't specify a border radius, but this looks about right.
      this.borderRadius = defaultBorderRadius,
      this.centered = false,
      Key key})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StretchableButton(
      buttonColor: darkMode ? Color(0xFF4285F4) : Colors.white,
      borderRadius: borderRadius,
      splashColor: splashColor,
      onPressed: onPressed,
      buttonPadding: 0.0,
      centered: centered,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 38.0, // 40dp - 2*1dp border
            width: 38.0, // matches above
            decoration: BoxDecoration(
              color: darkMode ? Colors.white : null,
              borderRadius: BorderRadius.circular(this.borderRadius),
            ),
            child: Center(child: Icon(Icons.phone)),
          ),
        ),
        SizedBox(width: 14.0 /* 24.0 - 10dp padding */),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color:
                      darkMode ? Colors.white : Colors.black.withOpacity(0.54),
                ),
          ),
        ),
      ],
    );
  }
}
