import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

/// A single saved account (bank or e-wallet).
class _Account {
  final String name;
  final String number;
  final Color color;
  final IconData icon;
  const _Account(this.name, this.number, this.color, this.icon);
}

/// "Metode Pembayaran": shows the member's bank and e-wallet accounts.
///
/// Display-only because the app is offline (no real transactions).
class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  static const _banks = [
    _Account('Bank BCA', '1234 5678 9012', Color(0xFF1A4FA0), Icons.account_balance),
    _Account('Bank Mandiri', '0987 6543 2100', Color(0xFF003D79), Icons.account_balance),
  ];

  static const _wallets = [
    _Account('GoPay', '0812-3456-7890', Color(0xFF00AED6), Icons.account_balance_wallet),
    _Account('OVO', '0812-3456-7890', Color(0xFF4B2E83), Icons.account_balance_wallet),
    _Account('DANA', '0812-3456-7890', Color(0xFF108EE9), Icons.account_balance_wallet),
  ];

  @override
  Widget build(BuildContext context) {
    final holder = auth.currentUser?.name ?? 'Anggota';
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(title: const Text('Metode Pembayaran')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primaryDark, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Aplikasi bersifat offline — akun di bawah hanya tampilan.',
                    style: TextStyle(color: AppColors.primaryDark, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Rekening Bank',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ..._banks.map((a) => _card(context, a, holder)),
          const SizedBox(height: 20),
          const Text(
            'Dompet Digital (E-Wallet)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ..._wallets.map((a) => _card(context, a, holder)),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, _Account a, String holder) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [a.color, a.color.withOpacity(0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(a.icon, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  a.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'a.n. $holder',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, color: Colors.white, size: 20),
            tooltip: 'Salin nomor',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: a.number));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Nomor ${a.name} disalin'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
