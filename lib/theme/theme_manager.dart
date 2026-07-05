import 'package:flutter/material.dart';

/// Available color themes for the app.
enum AppColorTheme {
  teal,
  purple,
  blue,
  orange,
  green,
  red,
  indigo,
  rose,
  sky,
  amber,
  slate,
}

/// Human-readable name and colors for each theme.
extension AppColorThemeLabel on AppColorTheme {
  String get label {
    switch (this) {
      case AppColorTheme.teal:   return 'Teal';
      case AppColorTheme.purple: return 'Ungu';
      case AppColorTheme.blue:   return 'Biru';
      case AppColorTheme.orange: return 'Oranye';
      case AppColorTheme.green:  return 'Hijau';
      case AppColorTheme.red:    return 'Merah';
      case AppColorTheme.indigo: return 'Indigo';
      case AppColorTheme.rose:   return 'Merah Muda';
      case AppColorTheme.sky:    return 'Langit';
      case AppColorTheme.amber:  return 'Amber';
      case AppColorTheme.slate:  return 'Abu-Abu';
    }
  }

  Color get primaryColor {
    switch (this) {
      case AppColorTheme.teal:   return const Color(0xFF15A196);
      case AppColorTheme.purple: return const Color(0xFF7C3AED);
      case AppColorTheme.blue:   return const Color(0xFF2563EB);
      case AppColorTheme.orange: return const Color(0xFFEA580C);
      case AppColorTheme.green:  return const Color(0xFF16A34A);
      case AppColorTheme.red:    return const Color(0xFFDC2626);
      case AppColorTheme.indigo: return const Color(0xFF4338CA);
      case AppColorTheme.rose:   return const Color(0xFFE11D48);
      case AppColorTheme.sky:    return const Color(0xFF0284C7);
      case AppColorTheme.amber:  return const Color(0xFFD97706);
      case AppColorTheme.slate:  return const Color(0xFF475569);
    }
  }

  Color get primaryDarkColor {
    switch (this) {
      case AppColorTheme.teal:   return const Color(0xFF0F766E);
      case AppColorTheme.purple: return const Color(0xFF5B21B6);
      case AppColorTheme.blue:   return const Color(0xFF1D4ED8);
      case AppColorTheme.orange: return const Color(0xFFC2410C);
      case AppColorTheme.green:  return const Color(0xFF15803D);
      case AppColorTheme.red:    return const Color(0xFFB91C1C);
      case AppColorTheme.indigo: return const Color(0xFF3730A3);
      case AppColorTheme.rose:   return const Color(0xFFBE123C);
      case AppColorTheme.sky:    return const Color(0xFF0369A1);
      case AppColorTheme.amber:  return const Color(0xFFB45309);
      case AppColorTheme.slate:  return const Color(0xFF334155);
    }
  }

  Color get primaryLightColor {
    switch (this) {
      case AppColorTheme.teal:   return const Color(0xFFE6F4F2);
      case AppColorTheme.purple: return const Color(0xFFF5F0FF);
      case AppColorTheme.blue:   return const Color(0xFFEFF6FF);
      case AppColorTheme.orange: return const Color(0xFFFFF7ED);
      case AppColorTheme.green:  return const Color(0xFFF0FDF4);
      case AppColorTheme.red:    return const Color(0xFFFEF2F2);
      case AppColorTheme.indigo: return const Color(0xFFEEF2FF);
      case AppColorTheme.rose:   return const Color(0xFFFFF1F2);
      case AppColorTheme.sky:    return const Color(0xFFE0F2FE);
      case AppColorTheme.amber:  return const Color(0xFFFFFBEB);
      case AppColorTheme.slate:  return const Color(0xFFF1F5F9);
    }
  }

  Color get scaffoldColor {
    switch (this) {
      case AppColorTheme.teal:   return const Color(0xFFF6F8F7);
      case AppColorTheme.purple: return const Color(0xFFF8F6FF);
      case AppColorTheme.blue:   return const Color(0xFFF6F8FF);
      case AppColorTheme.orange: return const Color(0xFFFFF8F5);
      case AppColorTheme.green:  return const Color(0xFFF6FBF7);
      case AppColorTheme.red:    return const Color(0xFFFFF6F6);
      case AppColorTheme.indigo: return const Color(0xFFF6F7FF);
      case AppColorTheme.rose:   return const Color(0xFFFFF5F7);
      case AppColorTheme.sky:    return const Color(0xFFF0F9FF);
      case AppColorTheme.amber:  return const Color(0xFFFFFDF0);
      case AppColorTheme.slate:  return const Color(0xFFF8FAFC);
    }
  }
}

/// Global theme manager. Notifies listeners on theme change.
class ThemeManager extends ChangeNotifier {
  AppColorTheme _current = AppColorTheme.teal;

  AppColorTheme get current => _current;

  void setTheme(AppColorTheme theme) {
    if (_current == theme) return;
    _current = theme;
    notifyListeners();
  }
}

/// Global singleton.
final ThemeManager themeManager = ThemeManager();
