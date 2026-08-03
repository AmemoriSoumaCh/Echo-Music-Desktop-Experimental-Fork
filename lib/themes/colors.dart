import 'package:flutter/material.dart';

Color greyColor = Colors.grey.withAlpha(100);
Color darkGreyColor = Colors.grey.withAlpha(70);
const MaterialColor primaryBlack = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color.fromRGBO(0, 0, 0, .1),
    100: Color.fromRGBO(0, 0, 0, .2),
    200: Color.fromRGBO(0, 0, 0, .3),
    300: Color.fromRGBO(0, 0, 0, .4),
    400: Color.fromRGBO(0, 0, 0, .5),
    500: Color.fromRGBO(0, 0, 0, .6),
    600: Color.fromRGBO(0, 0, 0, .7),
    700: Color.fromRGBO(0, 0, 0, .8),
    800: Color.fromRGBO(0, 0, 0, .9),
    900: Color.fromRGBO(0, 0, 0, 1),
  },
);

const MaterialColor primaryWhite = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color.fromRGBO(255, 255, 255, .1),
    100: Color.fromRGBO(255, 255, 255, .2),
    200: Color.fromRGBO(255, 255, 255, .3),
    300: Color.fromRGBO(255, 255, 255, .4),
    400: Color.fromRGBO(255, 255, 255, .5),
    500: Color.fromRGBO(255, 255, 255, .6),
    600: Color.fromRGBO(255, 255, 255, .7),
    700: Color.fromRGBO(255, 255, 255, .8),
    800: Color.fromRGBO(255, 255, 255, .9),
    900: Color.fromRGBO(255, 255, 255, 1),
  },
);

class AppColors
{
  static ColorScheme colorScheme(BuildContext context)
  {
    return Theme.of(context).colorScheme;
  }
  static Color outline(BuildContext context)
  {
    return colorScheme(context).outline;
  }
  static Color subtitleColor(BuildContext context)
  {
    return colorScheme(context).onSurface.withAlpha(150);
  }
  static Color titleColor(BuildContext context)
  {
    return colorScheme(context).onSurface;
  }
  static Color onSearchBar(BuildContext context)
  {
    return colorScheme(context).onSecondary;
  }
  static Color searchBar(BuildContext context)
  {
    return colorScheme(context).secondary;
  }
  static Color shadow(BuildContext context)
  {
    return colorScheme(context).primary;
  }
  static Color window(BuildContext context)
  {
    return colorScheme(context).surfaceContainer;
  }
  static Color inverseWindow(BuildContext context)
  {
    return onWindow(context);
  }
  static Color onInverseWindow(BuildContext context)
  {
    return window(context);
  }
  static Color onWindow(BuildContext context)
  {
    return colorScheme(context).onSurface;
  }
  static Color windowIcon(BuildContext context)
  {
    return colorScheme(context).onSurface;
  }
  static Color thumbnailError(BuildContext context)
  {
    return colorScheme(context).tertiary;
  }
  static Color onThumbnailError(BuildContext context)
  {
    return colorScheme(context).onTertiary;
  }
  static Color button(BuildContext context)
  {
    return colorScheme(context).primary;
  }
  static Color onButton(BuildContext context)
  {
    return colorScheme(context).onPrimary;
  }
  static Color floatingPlayer(BuildContext context)
  {
    return colorScheme(context).primary;
  }
  static Color onFloatingPlayer(BuildContext context)
  {
    return colorScheme(context).secondary;
  }

}
