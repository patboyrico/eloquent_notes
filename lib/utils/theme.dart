import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.white
  );
}

TextStyle headingFontStyle({fontsize, color}) {
  return TextStyle(
      
      fontFamily: 'AlegreyaSansSC',
      color: color,
      fontSize: fontsize,
      fontWeight: FontWeight.bold);
}
