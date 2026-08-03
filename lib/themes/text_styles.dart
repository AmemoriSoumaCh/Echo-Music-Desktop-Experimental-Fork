import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final defaultFontStyle = GoogleFonts.poppins();
TextStyle bigTextStyle({Color? color,
    double opacity = 1, bool bold = true}) {
  return customTextStyle(
    fontSize: 30,
    bold: bold,
    color: color,
    opacity: opacity);
}

TextStyle mediumTextStyle({Color? color,
    double opacity = 1, bool bold = true}) {
  return customTextStyle(
    fontSize: 24,
    bold: bold,
    color: color,
    opacity: opacity);
}

TextStyle textStyle({Color? color,
    double opacity = 1, bool bold = true}) {
  return customTextStyle(
    fontSize: 19,
    bold: bold,
    color: color,
    opacity: opacity);
}

TextStyle subtitleTextStyle({Color? color,
    double opacity = 1, bool bold = false}) {
  return customTextStyle(
    fontSize: 15,
    bold: bold,
    color: color,
    opacity: opacity);
}

TextStyle smallTextStyle({Color? color,
    double opacity = 1, bool bold = false}) {
  return customTextStyle(
    fontSize: 13,
    bold: bold,
    color: color,
    opacity: opacity);
}

TextStyle tinyTextStyle({Color? color,
    double opacity = 1, bool bold = false}) {
  return customTextStyle(
    fontSize: 11,
    bold: bold,
    color: color,
    opacity: opacity);
}

TextStyle customTextStyle({Color? color,
    double opacity = 1, bool bold = false, FontWeight weight = FontWeight.normal, double? fontSize, double? height, double? letterSpacing}) {
    opacity>1?opacity=1:opacity;
  return defaultFontStyle.copyWith(
      fontSize: fontSize,
      fontWeight: bold ? FontWeight.w600 : weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color?.withAlpha((opacity*255).round())
   );
}

TextStyle appBarTitleStyle() {
  return customTextStyle(
    fontSize: 20,
    bold: true,
  );
}
