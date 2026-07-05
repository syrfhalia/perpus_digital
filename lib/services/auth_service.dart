import 'package:flutter/foundation.dart';
import '../models/user.dart';

/// Result of an authentication attempt.
class AuthResult {
  final bool success;
  final String? error;
  const AuthResult(this.success, [this.error]);
}

/// In-memory authentication with dummy data.
///
/// Not a real backend — accounts live only for the app session.
class AuthService extends ChangeNotifier {
  final List<AppUser> _users = [
    const AppUser(
      name: 'Syarifah Nur Alia',
      email: 'syarifahnuralia@perpus.id',
      password: 'password123',
      level: 'Anggota Premium',
      memberId: 'PD-2024-00817',
      phone: '0812-3456-7890',
    ),
  ];

  AppUser? _current;

  AppUser? get currentUser => _current;
  bool get isLoggedIn => _current != null;

  AuthResult login(String email, String password) {
    final e = email.trim().toLowerCase();
    if (e.isEmpty || password.isEmpty) {
      return const AuthResult(false, 'Email dan kata sandi wajib diisi');
    }
    AppUser? match;
    for (final u in _users) {
      if (u.email.toLowerCase() == e && u.password == password) {
        match = u;
        break;
      }
    }
    if (match == null) {
      return const AuthResult(false, 'Email atau kata sandi salah');
    }
    _current = match;
    notifyListeners();
    return const AuthResult(true);
  }

  /// Registers a new account. Does NOT log the user in — they must log in
  /// afterwards from the login screen.
  AuthResult register(String name, String email, String password) {
    final n = name.trim();
    final e = email.trim().toLowerCase();
    if (n.isEmpty || e.isEmpty || password.isEmpty) {
      return const AuthResult(false, 'Semua field wajib diisi');
    }
    if (!e.contains('@') || !e.contains('.')) {
      return const AuthResult(false, 'Format email tidak valid');
    }
    if (password.length < 6) {
      return const AuthResult(false, 'Kata sandi minimal 6 karakter');
    }
    if (_users.any((u) => u.email.toLowerCase() == e)) {
      return const AuthResult(false, 'Email sudah terdaftar');
    }
    final id = 'PD-2024-${(_users.length + 100).toString().padLeft(5, '0')}';
    _users.add(AppUser(name: n, email: e, password: password, memberId: id));
    return const AuthResult(true);
  }

  /// Update the profile of the logged-in user.
  void updateProfile({String? name, String? email, String? phone}) {
    if (_current == null) return;
    final updated = _current!.copyWith(name: name, email: email, phone: phone);
    _replaceCurrent(updated);
  }

  /// Set a new profile photo for the logged-in user.
  void updatePhoto(Uint8List bytes) {
    if (_current == null) return;
    _replaceCurrent(_current!.copyWith(photoBytes: bytes));
  }

  /// Change the password of the logged-in user.
  AuthResult changePassword(String oldPass, String newPass, String confirm) {
    if (_current == null) return const AuthResult(false, 'Belum masuk');
    if (oldPass != _current!.password) {
      return const AuthResult(false, 'Kata sandi lama salah');
    }
    if (newPass.length < 6) {
      return const AuthResult(false, 'Kata sandi baru minimal 6 karakter');
    }
    if (newPass != confirm) {
      return const AuthResult(false, 'Konfirmasi kata sandi tidak cocok');
    }
    _replaceCurrent(_current!.copyWith(password: newPass));
    return const AuthResult(true);
  }

  void _replaceCurrent(AppUser updated) {
    final idx = _users.indexWhere((u) => u.email == _current!.email);
    if (idx != -1) _users[idx] = updated;
    _current = updated;
    notifyListeners();
  }

  void logout() {
    _current = null;
    notifyListeners();
  }
}

/// Global singleton used across the app.
final AuthService auth = AuthService();
