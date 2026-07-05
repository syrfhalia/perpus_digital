import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/theme_manager.dart';

/// "Pengaturan": app preferences (local/dummy toggles) + tema warna.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotif   = true;
  bool _emailNotif  = false;
  bool _dueReminder = true;
  String _language  = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeManager,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffold,
          appBar: AppBar(
            title: const Text('Pengaturan'),
            backgroundColor: AppColors.scaffold,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Tema Warna ──────────────────────────────────────────
              _section('Tema Warna'),
              _themeCard(),
              const SizedBox(height: 20),

              // ── Notifikasi ──────────────────────────────────────────
              _section('Notifikasi'),
              _card([
                _switchTile(
                  Icons.notifications_active_outlined,
                  'Notifikasi Push',
                  'Terima pemberitahuan di perangkat',
                  _pushNotif,
                  (v) => setState(() => _pushNotif = v),
                ),
                _divider(),
                _switchTile(
                  Icons.email_outlined,
                  'Notifikasi Email',
                  'Terima ringkasan lewat email',
                  _emailNotif,
                  (v) => setState(() => _emailNotif = v),
                ),
                _divider(),
                _switchTile(
                  Icons.schedule,
                  'Pengingat Jatuh Tempo',
                  'Ingatkan sebelum buku jatuh tempo',
                  _dueReminder,
                  (v) => setState(() => _dueReminder = v),
                ),
              ]),
              const SizedBox(height: 20),

              // ── Tampilan ────────────────────────────────────────────
              _section('Tampilan'),
              _card([
                _selectTile(
                  Icons.language,
                  'Bahasa',
                  _language,
                  () => _pickLanguage(),
                ),
              ]),
              const SizedBox(height: 20),

              // ── Lainnya ─────────────────────────────────────────────
              _section('Lainnya'),
              _card([
                _navTile(Icons.help_outline, 'Pusat Bantuan'),
                _divider(),
                _navTile(Icons.privacy_tip_outlined, 'Kebijakan Privasi'),
                _divider(),
                _navTile(Icons.info_outline, 'Tentang Aplikasi',
                    trailing: 'v1.0.0'),
              ]),
            ],
          ),
        );
      },
    );
  }

  // ── Theme card ───────────────────────────────────────────────────────────

  Widget _themeCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_outlined, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              const Text(
                'Pilih Tema',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: AppColorTheme.values.map(_themeCircle).toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Aktif: ${themeManager.current.label}',
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
    );
  }

  Widget _themeCircle(AppColorTheme scheme) {
    final isActive = themeManager.current == scheme;
    return GestureDetector(
      onTap: () => themeManager.setTheme(scheme),
      child: Tooltip(
        message: scheme.label,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: scheme.primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? Colors.black54 : Colors.transparent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: scheme.primaryColor.withOpacity(0.4),
                blurRadius: isActive ? 10 : 4,
                spreadRadius: isActive ? 2 : 0,
              ),
            ],
          ),
          child: isActive
              ? const Icon(Icons.check, color: Colors.white, size: 20)
              : null,
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  void _pickLanguage() {
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Indonesia', 'English'].map((lang) {
              return ListTile(
                title: Text(lang),
                trailing: _language == lang
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _language = lang);
                  Navigator.pop(ctx);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: children),
    );
  }

  Widget _divider() => const Divider(height: 1, thickness: 1, color: AppColors.divider);

  Widget _switchTile(
    IconData icon,
    String title,
    String sub,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark)),
                Text(sub,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _selectTile(
    IconData icon,
    String title,
    String value,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark)),
            ),
            Text(value,
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 14)),
            const Icon(Icons.chevron_right, color: AppColors.textFaint),
          ],
        ),
      ),
    );
  }

  Widget _navTile(IconData icon, String title, {String? trailing}) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Membuka $title'),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ),
            if (trailing != null)
              Text(trailing,
                  style: const TextStyle(
                      color: AppColors.textFaint, fontSize: 13))
            else
              const Icon(Icons.chevron_right, color: AppColors.textFaint),
          ],
        ),
      ),
    );
  }
}
