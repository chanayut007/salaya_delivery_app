import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/core/constants/font_constant.dart';

TextStyle _getTextStyle( double fontSize, Color color, FontWeight fontWeight,) {
  return TextStyle(
    fontFamily: FontConstant.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color
  );
}

TextStyle getLightTextStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, color, FontConstant.light);
}

TextStyle getRegularTextStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, color, FontConstant.regular);
}

TextStyle getMediumTextStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, color, FontConstant.medium);
}

TextStyle getSemiBoldTextStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, color, FontConstant.semiBold);
}

TextStyle getBoldTextStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, color, FontConstant.bold);
}