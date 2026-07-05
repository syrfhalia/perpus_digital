import 'book.dart';

enum LoanStatus { active, finished }

/// A book loan record for the current member.
class Loan {
  final Book book;
  final String borrowedDate;
  final String dueDate;
  final LoanStatus status;
  final bool renewable;

  const Loan({
    required this.book,
    required this.borrowedDate,
    required this.dueDate,
    required this.status,
    this.renewable = true,
  });
}
