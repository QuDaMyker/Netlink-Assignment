import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/constant/app_constants.dart';

final _tbTextColor = AppColors.textColor;

var tbTypography = Typography.material2018();

const tbFeatherGreen = MaterialColor(0xFF58cc02, <int, Color>{
  50: Color(0xFF58cc02),
  100: Color(0xFF58cc02),
  200: Color(0xFF58cc02),
  300: Color(0xFF58cc02),
  400: Color(0xFF58cc02),
  500: Color(0xFF58cc02),
  600: Color(0xFF58cc02),
  700: Color(0xFF58cc02),
  800: Color(0xFF58cc02),
  900: Color(0xFF58cc02),
});

final ThemeData theme = ThemeData(primarySwatch: tbFeatherGreen);

ThemeData appTheme = ThemeData(
  fontFamily: AppConstants.appFontFamily,
  useMaterial3: true,
  primarySwatch: tbFeatherGreen,
  colorScheme: theme.colorScheme.copyWith(
    primary: tbFeatherGreen,
    secondary: AppColors.macaw,
  ),
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  textTheme: theme.textTheme.apply(
    fontFamily: AppConstants.appFontFamily,
    bodyColor: AppColors.textColor,
    displayColor: AppColors.textColor,
  ),
  primaryTextTheme: tbTypography.black,
  typography: tbTypography,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: _tbTextColor,
    iconTheme: IconThemeData(color: _tbTextColor),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: tbFeatherGreen,
    unselectedItemColor: Colors.black.withValues(alpha: .38),
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  // pageTransitionsTheme: const PageTransitionsTheme(
  //   builders: {
  //     TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
  //     TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
  //   },
  // ),
);
