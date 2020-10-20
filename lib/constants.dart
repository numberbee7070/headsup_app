import 'package:flutter/material.dart';

class AppConstants {
  double height;
  double width;

  AppConstants(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print("height : $height; width : $width");
  }
}
