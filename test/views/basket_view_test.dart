import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/order_record.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/bookings_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const Movie testMovie = Movie(
  id: '1',
  title: 'Wildwood',
  ageRating: 'PG13',
  duration: '2h 10m',
  pricing: 10.99,
  synopsis:
      'After her baby brother is abducted by a murder of crows, headstrong teenager Prue McKeel launches a desperate rescue mission into an enchanted forest hidden just beyond Portland, Ore.',
  posterImagePath: 'assets/images/wildwood.jpg',
);

void main() {
  setUp(() async {
    CartRepository.instance.clear();
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

  testWidgets('BasketView displays empty message when basket has no items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BasketView()));

    expect(find.text('Your basket is empty'), findsOneWidget);
    expect(find.text('Checkout'), findsNothing);
  });

  testWidgets(
    'BasketView renders items and removes item when delete pressed',
    (WidgetTester tester) async {
      const CartItem item = CartItem(
        movie: testMovie,
        ticketQuantity: 2,
      );
      CartRepository.instance.addItem(item);

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      expect(find.text('Your basket'), findsOneWidget);
      expect(find.text('2 x Wildwood'), findsOneWidget);
      expect(find.text('£21.98'), findsWidgets);
      expect(find.text('Checkout'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pump();

      expect(find.text('Your basket is empty'), findsOneWidget);
    },
  );

  testWidgets('Checkout saves the order, clears the basket and opens orders', (
    WidgetTester tester,
  ) async {
    CartRepository.instance.addItem(
      const CartItem(movie: testMovie, ticketQuantity: 2),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: const BasketView(),
        routes: {
          '/orders': (BuildContext context) {
            return const BookingsView();
          },
        },
      ),
    );
    await tester.runAsync(() async {
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    final List<OrderRecord>? orders = await tester.runAsync(() async {
      return await MovieDatabase.instance.getAllOrders();
    });

    expect(orders, isNotNull);
    if (orders != null) {
      expect(orders.length, 1);
      expect(orders[0].orderNumber, 1001);
      expect(orders[0].summary, '2 x Wildwood');
      expect(orders[0].total, 23.48);
    }
    expect(CartRepository.instance.getItems(), isEmpty);
    expect(find.byType(BookingsView), findsOneWidget);
    expect(find.text('Order #1001'), findsOneWidget);
  });

  testWidgets('Checkout keeps the basket when saving fails', (
    WidgetTester tester,
  ) async {
    CartRepository.instance.addItem(
      const CartItem(movie: testMovie, ticketQuantity: 2),
    );
    await tester.runAsync(() async {
      final Database database = await MovieDatabase.instance.database;
      await database.execute('DROP TABLE orders');
    });

    await tester.pumpWidget(const MaterialApp(home: BasketView()));
    await tester.runAsync(() async {
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
    });
    await tester.pumpAndSettle();

    expect(CartRepository.instance.getItems().length, 1);
    expect(find.text('2 x Wildwood'), findsOneWidget);
    expect(find.textContaining('Could not save your order'), findsOneWidget);
  });
}
