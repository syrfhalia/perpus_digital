import 'package:flutter/material.dart';
import 'theme_manager.dart';

/// Runtime colors derived from the active theme.
class AppColors {
  static Color get primary      => themeManager.current.primaryColor;
  static Color get primaryDark  => themeManager.current.primaryDarkColor;
  static Color get primaryLight => themeManager.current.primaryLightColor;
  static Color get scaffold     => themeManager.current.scaffoldColor;

  static const Color accent    = Color(0xFFF5B50A);
  static const Color card      = Colors.white;
  static const Color loanCard  = Color(0xFFF1F7F5);

  static const Color textDark  = Color(0xFF1F2937);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color textFaint = Color(0xFF9CA3AF);

  static const Color divider   = Color(0xFFECEFEE);
  static const Color danger    = Color(0xFFEF4444);
}

class AppTheme {
  static ThemeData light([AppColorTheme? scheme]) {
    final color = (scheme ?? themeManager.current).primaryColor;

    final bg    = (scheme ?? themeManager.current).scaffoldColor;
    final base  = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: bg,
      colorScheme: base.colorScheme.copyWith(
        primary:   color,
        secondary: color,
        surface:   Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.textDark,
        titleTextStyle: const TextStyle(
          color: AppColors.textDark,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor:    AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
