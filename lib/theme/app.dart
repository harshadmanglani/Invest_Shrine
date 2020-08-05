import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

final ThemeData kAppTheme = _buildTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: iconColor);
}

var appBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(15)),
);

OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[300]),
    borderRadius: BorderRadius.all(Radius.circular(20.0)));

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
    textTheme: GoogleFonts.ralewayTextTheme(_buildTextTheme(base.textTheme)),
    primaryTextTheme:
        GoogleFonts.ralewayTextTheme(_buildTextTheme(base.textTheme)),
    accentTextTheme:
        GoogleFonts.ralewayTextTheme(_buildTextTheme(base.textTheme)),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        // headline1: base.headline1.copyWith(
        //   fontWeight: FontWeight.w800,
        // ),
        // headline2: base.headline2.copyWith(
        //   fontWeight: FontWeight.w700,
        // ),
        // headline3: base.headline3.copyWith(
        //   fontWeight: FontWeight.w600,
        // ),
        headline4: base.headline4.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 20.5,
        ),
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 19.5,
        ),
        headline6:
            base.headline6.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
        // caption: base.caption.copyWith(fontSize: 12),
        bodyText1: base.bodyText1.copyWith(
          fontSize: 15.0,
        ),
        bodyText2: base.bodyText2.copyWith(
          fontSize: 16.0,
        ),
      )
      .apply(bodyColor: textColor, displayColor: textColor);
}
