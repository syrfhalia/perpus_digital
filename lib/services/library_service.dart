import 'package:flutter/foundation.dart';
import '../models/app_notification.dart';
import '../models/book.dart';
import '../models/loan.dart';

/// Manages the member's borrowed books and notifications (in-memory, no backend).
class LibraryService extends ChangeNotifier {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  static String formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_months[d.month - 1]} ${d.year}';

  final List<Loan> _active = [];
  final List<Loan> _finished = [];
  final List<AppNotification> _notifications = [];

  List<Loan> get activeLoans    => List.unmodifiable(_active);
  List<Loan> get finishedLoans  => List.unmodifiable(_finished);
  List<AppNotification> get notifications => List.unmodifiable(_notifications);

  int get activeCount      => _active.length;
  int get finishedCount    => _finished.length;
  int get notificationCount => _notifications.length;
  int get unreadCount      => _notifications.where((n) => n.unread).length;

  bool isBorrowed(Book book) => _active.any((l) => l.book.id == book.id);

  /// Whether a book can currently be borrowed by the member.
  bool canBorrow(Book book) => book.available && !isBorrowed(book);

  /// Borrow a book: adds it to the active loans. Returns false if not possible.
  bool borrow(Book book) {
    if (!canBorrow(book)) return false;
    final now = DateTime.now();
    final due = now.add(const Duration(days: 30));
    _active.insert(
      0,
      Loan(
        book: book,
        borrowedDate: formatDate(now),
        dueDate: formatDate(due),
        status: LoanStatus.active,
      ),
    );
    _addNotification(
      AppNotification(
        title: 'Peminjaman Berhasil',
        message:
            'Kamu meminjam "${book.title}". Jatuh tempo ${formatDate(due)}.',
        time: 'Baru saja',
        type: NotificationType.success,
        unread: true,
      ),
    );
    notifyListeners();
    return true;
  }

  /// Return a book: removes it from active loans and records it as finished.
  void returnLoan(Loan loan) {
    _active.removeWhere((l) => l.book.id == loan.book.id);
    _finished.insert(
      0,
      Loan(
        book: loan.book,
        borrowedDate: loan.borrowedDate,
        dueDate: formatDate(DateTime.now()),
        status: LoanStatus.finished,
      ),
    );
    _addNotification(
      AppNotification(
        title: 'Buku Dikembalikan',
        message: 'Terima kasih! "${loan.book.title}" telah dikembalikan.',
        time: 'Baru saja',
        type: NotificationType.info,
        unread: true,
      ),
    );
    notifyListeners();
  }

  /// Permanently delete one entry from the finished-loans history.
  void deleteFinishedLoan(Loan loan) {
    _finished.removeWhere((l) => l.book.id == loan.book.id);
    notifyListeners();
  }

  /// Delete ALL finished loan records.
  void clearFinishedLoans() {
    _finished.clear();
    notifyListeners();
  }

  void _addNotification(AppNotification n) => _notifications.insert(0, n);

  /// Marks every notification as read (badge/count resets to zero).
  void markNotificationsRead() {
    if (_notifications.isEmpty) return;
    for (var i = 0; i < _notifications.length; i++) {
      final n = _notifications[i];
      if (n.unread) {
        _notifications[i] = AppNotification(
          title: n.title,
          message: n.message,
          time: n.time,
          type: n.type,
          unread: false,
        );
      }
    }
    notifyListeners();
  }
}

/// Global singleton used across the app.
final LibraryService library = LibraryService();
