import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData kAppTheme = _buildTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: iconColor);
}

OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: textColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)));

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: navbarBackgroundColor,
    cursorColor: Colors.black,
    primaryColor: appBarColor, // background for appBar
    scaffoldBackgroundColor:
        backgroundColor, // background for scaffold body and login page background
    cardColor: cardColor, // cardColor
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: buttonColor, // button color, same as navbarBackgroundColor
      colorScheme: base.colorScheme.copyWith(
        secondary: textColor,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: iconColor),
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: textFieldBorder, focusedBorder: textFieldBorder),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6.copyWith(fontSize: 19.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w300,
          fontSize: 15.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: textColor,
        bodyColor: textColor,
      );
}
