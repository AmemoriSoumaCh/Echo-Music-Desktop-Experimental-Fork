import 'package:Echo/themes/text_styles.dart';
import 'package:Echo/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final defaultFontStyle = GoogleFonts.poppins();

ThemeData dynamicTheme({required Color seedColor, required Brightness brightness, required bool isAmoled}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
  );

  final bool isDark = brightness==Brightness.dark;

  return ThemeData.from(colorScheme: colorScheme, textTheme: appTextTheme()
  ).copyWith(
    scaffoldBackgroundColor: isAmoled&&isDark?Colors.black: colorScheme.surface,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: isAmoled&&isDark?Colors.black: colorScheme.surface,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: isAmoled&&isDark?Colors.black: colorScheme.surface,
      unselectedIconTheme: IconThemeData(color: colorScheme.primary),
      selectedIconTheme: IconThemeData(color: colorScheme.onSecondary),
      indicatorColor: colorScheme.secondary,
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 11),
      unselectedLabelTextStyle:
      TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 11),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colorScheme.surface,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (_) => const FadeForwardsPageTransitionsBuilder(),
      ),
    ),
  );
}
