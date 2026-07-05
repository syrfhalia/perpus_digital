import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';

void main() {
  runApp(const PerpusDigitalApp());
}

class PerpusDigitalApp extends StatelessWidget {
  const PerpusDigitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeManager,
      builder: (context, _) {
        return MaterialApp(
          title: 'Perpus Digital',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          home: const AuthGate(),
        );
      },
    );
  }
}

/// Shows the login flow when logged out, and the main app when logged in.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: auth,
      builder: (context, _) {
        return auth.isLoggedIn ? const MainScreen() : const LoginScreen();
      },
    );
  }
}
