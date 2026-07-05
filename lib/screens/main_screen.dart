import 'package:flutter/material.dart';
import '../services/library_service.dart';
import '../theme/app_theme.dart';
import '../theme/theme_manager.dart';
import 'home_screen.dart';
import 'loans_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

/// Root scaffold holding the five bottom-navigation tabs.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  // ── Tema cepat: bottom sheet ─────────────────────────────────────────────

  void _showThemePicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _ThemePickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onNavigate: _go),
      const SearchScreen(),
      const LoansScreen(),
      const ProfileScreen(),
      const NotificationsScreen(),
    ];

    return ListenableBuilder(
      listenable: themeManager,
      builder: (context, _) {
        return Scaffold(
          body: Stack(
            children: [
              IndexedStack(index: _index, children: pages),

              // ── Tombol tema mengambang (kanan bawah) ─────────────────
              Positioned(
                right: 16,
                bottom: 80,
                child: Tooltip(
                  message: 'Ganti Tema',
                  child: FloatingActionButton.small(
                    heroTag: 'theme_fab',
                    onPressed: _showThemePicker,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    child: const Icon(Icons.palette_outlined, size: 20),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  backgroundColor: Colors.white,
                  indicatorColor: AppColors.primaryLight,
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    final selected = states.contains(WidgetState.selected);
                    return TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color:
                          selected ? AppColors.primary : AppColors.textFaint,
                    );
                  }),
                ),
                child: ListenableBuilder(
                  listenable: library,
                  builder: (context, _) {
                    return NavigationBar(
                      height: 64,
                      selectedIndex: _index,
                      onDestinationSelected: _go,
                      labelBehavior:
                          NavigationDestinationLabelBehavior.alwaysShow,
                      destinations: [
                        _dest(Icons.home_outlined, Icons.home, 'Beranda'),
                        _dest(Icons.search, Icons.search, 'Cari'),
                        _dest(Icons.menu_book_outlined, Icons.menu_book,
                            'Pinjaman'),
                        _dest(Icons.person_outline, Icons.person, 'Profil'),
                        _notifDest(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  NavigationDestination _dest(
      IconData icon, IconData active, String label) {
    return NavigationDestination(
      icon: Icon(icon, color: AppColors.textFaint),
      selectedIcon: Icon(active, color: AppColors.primary),
      label: label,
    );
  }

  NavigationDestination _notifDest() {
    Widget withBadge(IconData icon, Color color) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, color: color),
          if (library.unreadCount > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.danger,
                  shape: BoxShape.circle,
                ),
                constraints:
                    const BoxConstraints(minWidth: 15, minHeight: 15),
                child: Text(
                  '${library.unreadCount}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return NavigationDestination(
      icon: withBadge(Icons.notifications_none, AppColors.textFaint),
      selectedIcon: withBadge(Icons.notifications, AppColors.primary),
      label: 'Notifikasi',
    );
  }
}

// ── Theme picker bottom sheet ─────────────────────────────────────────────

class _ThemePickerSheet extends StatelessWidget {
  const _ThemePickerSheet();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeManager,
      builder: (context, _) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.palette_outlined,
                      color: AppColors.primary, size: 22),
                  const SizedBox(width: 10),
                  const Text(
                    'Pilih Tema Warna',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 16,
                children:
                    AppColorTheme.values.map((scheme) {
                  final isActive = themeManager.current == scheme;
                  return GestureDetector(
                    onTap: () {
                      themeManager.setTheme(scheme);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: scheme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActive
                                  ? Colors.black54
                                  : Colors.transparent,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: scheme.primaryColor
                                    .withOpacity(isActive ? 0.5 : 0.25),
                                blurRadius: isActive ? 12 : 4,
                                spreadRadius: isActive ? 2 : 0,
                              ),
                            ],
                          ),
                          child: isActive
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 22)
                              : null,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          scheme.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isActive
                                ? scheme.primaryColor
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Selesai'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
