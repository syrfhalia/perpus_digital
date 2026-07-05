import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/library_service.dart';
import '../theme/app_theme.dart';

/// Detail page for a single book.
class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text('Detail Buku'),
        backgroundColor: AppColors.scaffold,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  book.coverAsset,
                  width: 180,
                  height: 260,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            book.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: AppColors.textMuted),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _stat(Icons.star, book.rating.toStringAsFixed(1), 'Rating'),
              _stat(Icons.menu_book, '${book.pages}', 'Halaman'),
              _stat(Icons.calendar_today, '${book.year}', 'Terbit'),
            ],
          ),
          const SizedBox(height: 20),
          ListenableBuilder(
            listenable: library,
            builder: (context, _) {
              final canBorrow = library.canBorrow(book);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: canBorrow
                      ? AppColors.primaryLight
                      : const Color(0xFFFDE8E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      canBorrow ? Icons.check_circle : Icons.cancel,
                      size: 18,
                      color: canBorrow ? AppColors.primary : AppColors.danger,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      canBorrow
                          ? 'Tersedia untuk dipinjam'
                          : 'Sedang dipinjam',
                      style: TextStyle(
                        color: canBorrow
                            ? AppColors.primaryDark
                            : AppColors.danger,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 22),
          const Text(
            'Sinopsis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.synopsis,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 18),
          _infoRow('Penerbit', book.publisher),
          _infoRow('Kategori', book.category),
          _infoRow('Jumlah Halaman', '${book.pages} halaman'),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 52,
            child: ListenableBuilder(
              listenable: library,
              builder: (context, _) {
                final canBorrow = library.canBorrow(book);
                return ElevatedButton.icon(
                  onPressed: canBorrow
                      ? () {
                          library.borrow(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Buku "${book.title}" berhasil dipinjam. '
                                  'Cek di tab Pinjaman.'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.book_online),
                  label: Text(canBorrow ? 'Pinjam Buku' : 'Sedang Dipinjam'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: AppColors.textDark,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textFaint),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
