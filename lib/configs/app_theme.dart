import 'package:flutter/material.dart';

import 'app_core_theme.dart';

class AppTheme {
  static final _core = AppCoreTheme(
    primary: const Color(0xffb0930a),
    primaryDark: const Color(0xff46536D),
    accent: const Color(0xff331D1D),
    shadow: Colors.black.withOpacity(0.20),
    shadowSub: Colors.black.withOpacity(0.12),
    textSub: const Color(0xff828282),
  );

  static AppCoreTheme light = _core.copyWith(
    background:  const Color(0xffe5cfcf),
    backgroundSub: const Color(0xffF0F0F0),
    scaffold: const Color(0xffe5cfcf),
    scaffoldDark: const Color(0xfffcf8f8),
    text: const Color(0xff484848),
    textSub2: Colors.black.withOpacity(0.25),
  );

  static AppCoreTheme dark = _core.copyWith(
    background: const Color(0xff1c1c1e),
    backgroundSub: const Color(0xff1c1c1e),
    scaffold: const Color(0xff0e0e0e),
    text: Colors.white,
    textSub2: Colors.white.withOpacity(0.25),
  );

  static AppCoreTheme? c;

  // Init
  static init(BuildContext context) {
    c = isDark(context) ? dark : light;
  }

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
