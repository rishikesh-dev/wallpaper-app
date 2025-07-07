import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/theme/colors_pallete.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    cardColor: AppColors.kBlack,
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColors.kBlack,
      labelColor: AppColors.kBlack,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.kBlack,
    ),
  );
  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    cardColor: AppColors.kWhite,
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColors.kWhite,
      labelColor: AppColors.kWhite,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.kWhite,
    ),
  );
}
