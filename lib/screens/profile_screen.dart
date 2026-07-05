import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/user_avatar.dart';
import 'change_password_screen.dart';
import 'digital_card_screen.dart';
import 'payment_method_screen.dart';
import 'profile_detail_screen.dart';
import 'settings_screen.dart';

/// "Profil" tab: member card and settings menu.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teal header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: const Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _memberCard(),
                  const SizedBox(height: 8),
                  _menuCard(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _memberCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListenableBuilder(
        listenable: auth,
        builder: (context, _) {
          final user = auth.currentUser;
          return Row(
            children: [
              UserAvatar(
                initials: user?.initials ?? '?',
                imageBytes: user?.photoBytes,
                radius: 30,
                fontSize: 22,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? 'Tamu',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.workspace_premium,
                            size: 15, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text(
                          user?.level ?? '-',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

  Widget _menuCard(BuildContext context) {
    final items = <Widget>[
      ProfileMenuItem(
        icon: Icons.credit_card,
        label: 'Kartu Digital',
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DigitalCardScreen()),
        ),
      ),
      _divider(),
      ProfileMenuItem(
        icon: Icons.person_outline,
        label: 'Profil Saya',
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ProfileDetailScreen()),
        ),
      ),
      _divider(),
      ProfileMenuItem(
        icon: Icons.settings_outlined,
        label: 'Pengaturan',
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        ),
      ),
      _divider(),
      ProfileMenuItem(
        icon: Icons.payment_outlined,
        label: 'Metode Pembayaran',
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
        ),
      ),
      _divider(),
      ProfileMenuItem(
        icon: Icons.lock_outline,
        label: 'Ganti Kata Sandi',
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
        ),
      ),
      _divider(),
      ProfileMenuItem(
        icon: Icons.logout,
        label: 'Keluar',
        color: AppColors.danger,
        showChevron: false,
        onTap: () => _confirmLogout(context),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _divider() => const Divider(height: 1, color: AppColors.divider);

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah kamu yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              auth.logout();
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
