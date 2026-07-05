import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/book.dart';
import '../services/auth_service.dart';
import '../services/library_service.dart';
import '../theme/app_theme.dart';
import '../widgets/book_cover.dart';
import '../widgets/section_header.dart';
import '../widgets/user_avatar.dart';
import 'book_detail_screen.dart';

/// "Beranda" tab: greeting header, quick stats and book carousels.
class HomeScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  void _openBook(BuildContext context, Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _header(context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _statsRow(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(
              title: 'Buku Populer',
              actionLabel: 'Lihat Semua',
              onAction: () => onNavigate(1),
            ),
          ),
          const SizedBox(height: 12),
          _carousel(context, SampleData.popular),
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(
              title: 'Rekomendasi Minggu Ini',
              actionLabel: 'Lihat Semua',
              onAction: () => onNavigate(1),
            ),
          ),
          const SizedBox(height: 12),
          _carousel(context, SampleData.recommended),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ListenableBuilder(
                    listenable: auth,
                    builder: (context, _) {
                      final user = auth.currentUser;
                      return Row(
                        children: [
                          UserAvatar(
                            initials: user?.initials ?? '?',
                            imageBytes: user?.photoBytes,
                            radius: 22,
                            fontSize: 16,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Selamat datang,',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 13),
                                ),
                                Text(
                                  user?.name ?? 'Tamu',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ListenableBuilder(
                  listenable: library,
                  builder: (context, _) {
                    return Stack(
                      children: [
                        IconButton(
                          onPressed: () => onNavigate(4),
                          icon: const Icon(Icons.notifications_none,
                              color: Colors.white),
                        ),
                        if (library.unreadCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () => onNavigate(1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: AppColors.textFaint),
                    SizedBox(width: 10),
                    Text(
                      'Cari judul, penulis, atau ISBN...',
                      style: TextStyle(color: AppColors.textFaint, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsRow() {
    return ListenableBuilder(
      listenable: library,
      builder: (context, _) {
        return Row(
          children: [
            _statCard(
              Icons.menu_book,
              '${library.activeCount}',
              'Pinjaman Aktif',
            ),
            const SizedBox(width: 12),
            _statCard(
              Icons.history,
              '${library.finishedCount}',
              'Selesai',
            ),
            const SizedBox(width: 12),
            _statCard(
              Icons.notifications_active,
              '${library.notificationCount}',
              'Notifikasi',
            ),
          ],
        );
      },
    );
  }

  Widget _statCard(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.textFaint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _carousel(BuildContext context, List<Book> books) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) {
          final b = books[i];
          return GestureDetector(
            onTap: () => _openBook(context, b),
            child: SizedBox(
              width: 116,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookCover(
                    asset: b.coverAsset,
                    width: 116,
                    height: 158,
                    radius: 12,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    b.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    b.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textFaint,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
