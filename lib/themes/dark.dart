import 'package:Echo/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final defaultFontStyle = GoogleFonts.poppins();

ThemeData darkTheme({required bool isAmoled}) {
  final colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 180, 180, 180),
    onSecondary: Colors.black,
    tertiary: Colors.grey,
    onTertiary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: isAmoled ? Colors.black : Color.fromARGB(255, 25, 25, 25),
    onSurface: Colors.white,
    surfaceContainer: isAmoled? Color.fromARGB(255, 25, 25, 25) : Color.fromARGB(255, 50, 50, 50),
    surfaceContainerLowest: isAmoled? Color.fromARGB(255, 10, 10, 10) : Color.fromARGB(255, 35, 35, 35),
    surfaceContainerLow: isAmoled? Color.fromARGB(255, 20, 20, 20) : Color.fromARGB(255, 45, 45, 45),
    surfaceContainerHigh: isAmoled? Color.fromARGB(255, 35, 35, 35) : Color.fromARGB(255, 60, 60, 60),
    surfaceContainerHighest: isAmoled? Color.fromARGB(255, 45, 45, 45) : Color.fromARGB(255, 75, 75, 75),
    inverseSurface: isAmoled? Colors.white : Color.fromARGB(255, 230, 230, 230),
    onInverseSurface: Colors.black,
    inversePrimary: Colors.black,
    primaryContainer: Color.fromARGB(255, 230, 230, 230),
    onPrimaryContainer:Colors.black,
    secondaryContainer: Color.fromARGB(255, 155, 155, 155),
    onSecondaryContainer: Colors.black,
    tertiaryContainer: Color.fromARGB(255, 103, 103, 103),
    onTertiaryContainer: Colors.white,
    );

    return ThemeData.from(colorScheme: colorScheme, textTheme: appTextTheme()
    ).copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        unselectedIconTheme: IconThemeData(color: colorScheme.primary),
        selectedIconTheme: IconThemeData(color: colorScheme.onPrimary),
        indicatorColor: colorScheme.secondary,
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: TextStyle(color: colorScheme.onSurface, fontSize: 11),
        unselectedLabelTextStyle:
        TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 11),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainer,
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => const FadeForwardsPageTransitionsBuilder(),
        ),
      ),
    );
}
