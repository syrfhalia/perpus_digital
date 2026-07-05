import 'dart:typed_data';

/// A registered member account.
class AppUser {
  final String name;
  final String email;
  final String password;
  final String level;
  final String memberId;
  final String phone;

  /// Optional profile photo picked by the user (works on web and mobile).
  final Uint8List? photoBytes;

  const AppUser({
    required this.name,
    required this.email,
    required this.password,
    this.level = 'Anggota Reguler',
    this.memberId = 'PD-2024-00000',
    this.phone = '-',
    this.photoBytes,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? password,
    String? level,
    String? memberId,
    String? phone,
    Uint8List? photoBytes,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      level: level ?? this.level,
      memberId: memberId ?? this.memberId,
      phone: phone ?? this.phone,
      photoBytes: photoBytes ?? this.photoBytes,
    );
  }

  /// Up to two uppercase initials derived from the name.
  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
