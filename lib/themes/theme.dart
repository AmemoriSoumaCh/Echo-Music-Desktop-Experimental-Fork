import 'package:Echo/themes/dynamic.dart';
import 'package:Echo/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:Echo/themes/dark.dart';

class AppTheme {

  static ThemeData light({Color? seedColor}) {
    if(seedColor!=null)
    {
      return dynamicTheme(seedColor: seedColor, brightness: Brightness.light, isAmoled: false);
    }
    else
    {
      return lightTheme();
    }
  }

  static ThemeData dark({Color? seedColor, bool? isAmoled}) {
    if(seedColor!=null)
    {
      return dynamicTheme(seedColor: seedColor, brightness: Brightness.dark, isAmoled: isAmoled??false);
    }
    else
    {
      return darkTheme(isAmoled: isAmoled??false);
    }
  }
}
