import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/theme/theme_pallete.dart';

class ThemeNotifier extends ValueNotifier {
  final Box settingsBox = Hive.box(AppConstants.settings);
  ThemeNotifier() : super(_getInitialTheme());
  bool get isDarkMode => value.brightness == Brightness.dark;
  static const String _themeKey = 'isDark';
  static ThemeData _getInitialTheme() {
    final box = Hive.box(AppConstants.settings);
    final isDark = box.get(_themeKey, defaultValue: false);
    return isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  void toggleTheme() {
    value = isDarkMode ? AppTheme.lightTheme : AppTheme.darkTheme;
    settingsBox.put(_themeKey, isDarkMode);
  }
}
