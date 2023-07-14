import 'package:flutter/material.dart';

import 'app_theme.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  fontFamily: fontFamily,
  primaryColor: AppTheme.light.primary,
  canvasColor: const Color(0xfff6f1f1),
  brightness: Brightness.light,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor:const Color(0xffe5cfcf),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ), colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: AppTheme.light.primary,
        background: AppTheme.light.background,
      ).copyWith(primary: Color(0xffb0930a), secondary: AppTheme.light.primary).copyWith(background: Colors.white),
);

final themeDark = ThemeData(
  fontFamily: fontFamily,
  primaryColor: AppTheme.light.primary,
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.grey[900],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ), colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: AppTheme.light.primary,
        background: AppTheme.light.background,
        brightness: Brightness.dark,
      ).copyWith(background: Colors.grey[800]),
);
