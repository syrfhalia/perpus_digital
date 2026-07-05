import 'package:flutter_test/flutter_test.dart';

import 'package:perpus_digital/data/sample_data.dart';
import 'package:perpus_digital/main.dart';
import 'package:perpus_digital/services/auth_service.dart';
import 'package:perpus_digital/services/library_service.dart';

void main() {
  testWidgets('Shows login, then main app after successful login',
      (WidgetTester tester) async {
    auth.logout();
    await tester.pumpWidget(const PerpusDigitalApp());
    await tester.pumpAndSettle();

    // Login screen is shown first.
    expect(find.text('Masuk'), findsWidgets);
    expect(find.text('Beranda'), findsNothing);

    // Log in with the dummy demo account.
    final result = auth.login('syarifahnuralia@perpus.id', 'password123');
    expect(result.success, isTrue);
    await tester.pumpAndSettle();

    // Main app tabs are now visible and greet the logged-in user.
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Syarifah Nur Alia'), findsWidgets);
  });

  testWidgets('Rejects invalid credentials', (WidgetTester tester) async {
    auth.logout();
    final result = auth.login('salah@email.com', 'wrong');
    expect(result.success, isFalse);
    expect(result.error, isNotNull);
  });

  test('Register does not auto-login; user must log in after', () {
    auth.logout();
    final reg = auth.register('Test User', 'testuser@perpus.id', 'rahasia123');
    expect(reg.success, isTrue);
    expect(auth.isLoggedIn, isFalse);

    final login = auth.login('testuser@perpus.id', 'rahasia123');
    expect(login.success, isTrue);
    expect(auth.isLoggedIn, isTrue);
  });

  test('Loans and notifications start empty', () {
    // A fresh member has no active/finished loans and no notifications until
    // they interact with the app.
    expect(library.activeCount, 0);
    expect(library.finishedCount, 0);
    expect(library.notificationCount, 0);
  });

  test('Borrowing adds a loan + notification; returning moves it to finished',
      () {
    final target = SampleData.books.firstWhere((b) => b.available);

    final activeBefore = library.activeCount;
    final notifBefore = library.notificationCount;
    library.borrow(target);
    expect(library.activeCount, activeBefore + 1);
    expect(library.isBorrowed(target), isTrue);
    expect(library.notificationCount, notifBefore + 1);

    final loan = library.activeLoans.firstWhere((l) => l.book.id == target.id);
    final finishedBefore = library.finishedCount;
    library.returnLoan(loan);
    expect(library.isBorrowed(target), isFalse);
    expect(library.activeCount, activeBefore);
    expect(library.finishedCount, finishedBefore + 1);
  });

  test('Change password validates old password and confirmation', () {
    auth.logout();
    auth.login('syarifahnuralia@perpus.id', 'password123');

    final wrongOld = auth.changePassword('salah', 'baru123', 'baru123');
    expect(wrongOld.success, isFalse);

    final mismatch = auth.changePassword('password123', 'baru123', 'lain123');
    expect(mismatch.success, isFalse);

    final ok = auth.changePassword('password123', 'baru123', 'baru123');
    expect(ok.success, isTrue);

    // Restore for other runs.
    auth.changePassword('baru123', 'password123', 'password123');
    auth.logout();
  });
}
