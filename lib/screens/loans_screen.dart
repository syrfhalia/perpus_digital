import 'package:flutter/material.dart';
import '../models/loan.dart';
import '../services/library_service.dart';
import '../theme/app_theme.dart';
import '../widgets/loan_card.dart';
import '../widgets/section_header.dart';
import 'book_detail_screen.dart';

/// "Riwayat Pinjaman" tab: active and finished loans.
class LoansScreen extends StatelessWidget {
  const LoansScreen({super.key});

  // ── Kembalikan ────────────────────────────────────────────────────────────

  void _returnBook(BuildContext context, Loan loan) {
    library.returnLoan(loan);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buku "${loan.book.title}" telah dikembalikan'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  // ── Hapus satu riwayat selesai ─────────────────────────────────────────

  void _deleteFinished(BuildContext context, Loan loan) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Riwayat'),
        content: Text(
            'Hapus riwayat peminjaman "${loan.book.title}" dari daftar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              library.deleteFinishedLoan(loan);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Riwayat dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // ── Hapus semua riwayat selesai ───────────────────────────────────────

  void _clearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Semua Riwayat'),
        content:
            const Text('Seluruh riwayat pinjaman selesai akan dihapus permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              library.clearFinishedLoans();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Semua riwayat dihapus')),
              );
            },
            child: const Text('Hapus Semua'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pinjaman')),
      body: ListenableBuilder(
        listenable: library,
        builder: (context, _) {
          final active   = library.activeLoans;
          final finished = library.finishedLoans;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            children: [
              // ── Pinjaman Aktif ──────────────────────────────────────
              const SectionHeader(title: 'Pinjaman Aktif'),
              const SizedBox(height: 12),
              if (active.isEmpty)
                _emptyState('Tidak ada pinjaman aktif')
              else
                ...active.map(
                  (l) => LoanCard(
                    loan: l,
                    onPrimaryAction: () => _returnBook(context, l),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookDetailScreen(book: l.book),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 12),

              // ── Riwayat Selesai ─────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: SectionHeader(title: 'Riwayat Selesai'),
                  ),
                  if (finished.isNotEmpty)
                    TextButton.icon(
                      onPressed: () => _clearAll(context),
                      icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                      label: const Text('Hapus Semua'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.danger,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              if (finished.isEmpty)
                _emptyState('Belum ada riwayat')
              else
                ...finished.map(
                  (l) => _FinishedLoanCard(
                    loan: l,
                    onDelete: () => _deleteFinished(context, l),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookDetailScreen(book: l.book),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyState(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: AppColors.textFaint),
      ),
    );
  }
}

// ── Finished-loan card with delete button ─────────────────────────────────

class _FinishedLoanCard extends StatelessWidget {
  final Loan loan;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _FinishedLoanCard({
    required this.loan,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(loan.book.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text('Hapus',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
      confirmDismiss: (_) async {
        bool confirmed = false;
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Hapus Riwayat'),
            content: Text(
                'Hapus riwayat "${loan.book.title}" dari daftar?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Batal')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  confirmed = true;
                  Navigator.pop(ctx);
                },
                child: const Text('Hapus'),
              ),
            ],
          ),
        );
        return confirmed;
      },
      onDismissed: (_) {
        library.deleteFinishedLoan(loan);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Riwayat dihapus')));
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              // Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  loan.book.coverAsset,
                  width: 52,
                  height: 72,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 52,
                    height: 72,
                    color: AppColors.primaryLight,
                    child: Icon(Icons.menu_book,
                        color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loan.book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      loan.book.author,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 6),
                    _dateRow('Dipinjam :', loan.borrowedDate),
                    _dateRow('Dikembalikan:', loan.dueDate),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '✓ Selesai',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Hapus button
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
                color: AppColors.danger,
                tooltip: 'Hapus riwayat',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateRow(String label, String value) {
    return Row(
      children: [
        Text(label,
            style:
                const TextStyle(fontSize: 11, color: AppColors.textFaint)),
        const SizedBox(width: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted)),
      ],
    );
  }
}
