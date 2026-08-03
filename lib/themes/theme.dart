import 'package:Echo/themes/dynamic.dart';
import 'package:Echo/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:Echo/themes/dark.dart';

class AppTheme {
  static ThemeData dynamic({Color? seedColor, Brightness? brightness, bool? isAmoled})
  {
    return dynamicTheme(seedColor: seedColor??Colors.white, brightness: brightness??Brightness.light, isAmoled: isAmoled??false);
  }

  static ThemeData light() {
    return lightTheme();
  }

  static ThemeData dark({bool? isAmoled}) {
    return darkTheme(isAmoled: isAmoled??false);
  }

}
