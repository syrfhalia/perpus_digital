import 'package:flutter/material.dart';
import '../models/loan.dart';
import '../theme/app_theme.dart';
import 'book_cover.dart';

/// Card showing a single loan with dates and an action button.
class LoanCard extends StatelessWidget {
  final Loan loan;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onTap;

  const LoanCard({
    super.key,
    required this.loan,
    this.onPrimaryAction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = loan.status == LoanStatus.active;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.loanCard : AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookCover(asset: loan.book.coverAsset, width: 52, height: 72),
                const SizedBox(width: 12),
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
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _dateRow('Dipinjam:', loan.borrowedDate),
                      const SizedBox(height: 2),
                      _dateRow('Jatuh Tempo:', loan.dueDate),
                    ],
                  ),
                ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: _actionButton(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dateRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textFaint),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _actionButton() {
    if (loan.renewable) {
      return ElevatedButton(
        onPressed: onPrimaryAction,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
        child: const Text('Kembalikan'),
      );
    }
    return OutlinedButton(
      onPressed: onPrimaryAction,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Perpanjang'),
    );
  }
}
