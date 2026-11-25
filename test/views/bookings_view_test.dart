import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/order_record.dart';
import 'package:southsea_cinema/views/bookings_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();
    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: MovieDatabase.instance.createTables,
      ),
    );
    MovieDatabase.instance.setDatabase(database);
  });

  tearDown(() async {
    await MovieDatabase.instance.close();
  });

  testWidgets('BookingsView lists saved orders newest-first', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await MovieDatabase.instance.insertOrder(
        const OrderRecord(
          orderNumber: 1001,
          summary: '1 x Wildwood ticket(s)',
          total: 10.99,
          date: '01/01/2026 10:00',
        ),
      );
      await MovieDatabase.instance.insertOrder(
        const OrderRecord(
          orderNumber: 1002,
          summary: '2 x Kubo and the Two Strings ticket(s)',
          total: 17.98,
          date: '02/01/2026 11:00',
        ),
      );
      await tester.pumpWidget(const MaterialApp(home: BookingsView()));
      await tester.pumpAndSettle();
    });

    await tester.pump();

    expect(find.text('Order #1002'), findsOneWidget);
    expect(find.text('Order #1001'), findsOneWidget);
    expect(find.text('2 x Kubo and the Two Strings ticket(s)'), findsOneWidget);
    final double newestY = tester.getTopLeft(find.text('Order #1002')).dy;
    final double oldestY = tester.getTopLeft(find.text('Order #1001')).dy;
    expect(newestY, lessThan(oldestY));
  });

  testWidgets('BookingsView shows an empty state when there are no orders', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const MaterialApp(home: BookingsView()));
      await tester.pumpAndSettle();
    });
    await tester.pump();

    expect(find.text('No orders yet'), findsOneWidget);
  });
}
