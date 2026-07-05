import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/user_avatar.dart';
import '../theme/app_theme.dart';

/// "Kartu Digital": a digital membership card with a scannable-looking code.
class DigitalCardScreen extends StatelessWidget {
  const DigitalCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(title: const Text('Kartu Digital')),
      body: ListenableBuilder(
        listenable: auth,
        builder: (context, _) {
          final u = auth.currentUser;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _card(u?.name ?? 'Anggota', u?.level ?? '-',
                  u?.memberId ?? '-', u?.initials ?? '?', u?.photoBytes),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: CustomPaint(
                        size: const Size(180, 180),
                        painter: _QrPainter(u?.memberId ?? 'PD'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Tunjukkan kode ini di meja peminjaman',
                      style:
                          TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _card(String name, String level, String memberId, String initials,
      dynamic photoBytes) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_library, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              const Text(
                'PERPUS DIGITAL',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              UserAvatar(
                initials: initials,
                imageBytes: photoBytes,
                radius: 22,
                fontSize: 16,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            level,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'ID ANGGOTA',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            memberId,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws a deterministic QR-like grid from a string (decorative, not scannable).
class _QrPainter extends CustomPainter {
  final String data;
  const _QrPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    const grid = 21;
    final cell = size.width / grid;
    final paint = Paint()..color = const Color(0xFF1F2937);

    final pattern = _pattern(grid);
    for (var y = 0; y < grid; y++) {
      for (var x = 0; x < grid; x++) {
        if (pattern[y][x]) {
          canvas.drawRect(
            Rect.fromLTWH(x * cell, y * cell, cell, cell),
            paint,
          );
        }
      }
    }

    // Three finder squares (corners), like a real QR code.
    _finder(canvas, paint, 0, 0, cell);
    _finder(canvas, paint, (grid - 7) * cell, 0, cell);
    _finder(canvas, paint, 0, (grid - 7) * cell, cell);
  }

  List<List<bool>> _pattern(int grid) {
    var hash = 7;
    for (final code in data.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    final rows = List.generate(grid, (_) => List.filled(grid, false));
    for (var y = 0; y < grid; y++) {
      for (var x = 0; x < grid; x++) {
        // Leave room for the finder squares.
        final inFinder = (x < 8 && y < 8) ||
            (x > grid - 9 && y < 8) ||
            (x < 8 && y > grid - 9);
        if (inFinder) continue;
        hash = (hash * 1103515245 + 12345) & 0x7fffffff;
        rows[y][x] = (hash >> 16) & 1 == 1;
      }
    }
    return rows;
  }

  void _finder(Canvas canvas, Paint paint, double left, double top, double cell) {
    canvas.drawRect(Rect.fromLTWH(left, top, cell * 7, cell * 7), paint);
    final white = Paint()..color = Colors.white;
    canvas.drawRect(
        Rect.fromLTWH(left + cell, top + cell, cell * 5, cell * 5), white);
    canvas.drawRect(
        Rect.fromLTWH(left + cell * 2, top + cell * 2, cell * 3, cell * 3),
        paint);
  }

  @override
  bool shouldRepaint(covariant _QrPainter old) => old.data != data;
}
