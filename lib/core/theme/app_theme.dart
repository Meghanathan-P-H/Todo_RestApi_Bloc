import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/app_colors.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppColors.backGroundColor,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.appBarColor),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.appColor));
}
