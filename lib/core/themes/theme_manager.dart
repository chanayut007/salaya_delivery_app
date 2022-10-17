import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/core/themes/font_manager.dart';

ThemeData getThemeApplication() {
  return ThemeData(
    primaryColor: ColorConstant.primary,

    disabledColor: ColorConstant.grey,

    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorConstant.primary,
      elevation: 0,
      titleTextStyle: getRegularTextStyle(fontSize: 16, color: ColorConstant.white)
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        textStyle: getRegularTextStyle(color: ColorConstant.white, fontSize: 16),
        primary: ColorConstant.blue,
        shape: const StadiumBorder(side: BorderSide.none)
      )
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
        textStyle: getMediumTextStyle(color: ColorConstant.blue, fontSize: 20)
      )
    ),

    textTheme: TextTheme(
      headline1: getSemiBoldTextStyle(color: ColorConstant.secondary, fontSize: 16),
      subtitle1: getMediumTextStyle(color: ColorConstant.black, fontSize: 14),
      caption: getRegularTextStyle(color: ColorConstant.black, fontSize: 14),
      bodyText1: getRegularTextStyle(color: ColorConstant.black, fontSize: 14),
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16),
      // hint style
      hintStyle: getRegularTextStyle(color: ColorConstant.grey),

      // enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: ColorConstant.black),
        borderRadius: BorderRadius.circular(100)
      ),

      // focus border
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: ColorConstant.black),
        borderRadius: BorderRadius.circular(100)
      ),
    )
  );
}