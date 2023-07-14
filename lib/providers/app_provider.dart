import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

final themeMap = {
  "dark": ThemeMode.dark,
  "light": ThemeMode.light,
};

class AppProvider extends ChangeNotifier {
  final _cache = Hive.box('app');

  ThemeMode? _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode!;
  bool get isDark => _themeMode == ThemeMode.dark;

  void initTheme() {
    String? stringTheme = _cache.get('theme');

    ThemeMode? theme =
        stringTheme == null ? ThemeMode.dark : themeMap[stringTheme];

    if (theme == null) {
      _cache.put(
        'theme',
        ThemeMode.light.toString().split(".").last,
      );
      _themeMode = ThemeMode.dark;
    }
    _themeMode = theme;

    notifyListeners();
  }

  void setTheme(ThemeMode newTheme) {
    if (_themeMode == newTheme) {
      return;
    }
    _themeMode = newTheme;

    _cache.put(
      'theme',
      newTheme.toString().split('.').last,
    );
    notifyListeners();
  }
}
