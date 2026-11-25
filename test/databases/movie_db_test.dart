import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/order_record.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

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

  OrderRecord buildRecord(int orderNumber, String summary, double total) {
    return OrderRecord(
      orderNumber: orderNumber,
      summary: summary,
      total: total,
      date: '01/01/2026 10:00',
    );
  }

  test('insertOrder stores an order and returns its id', () async {
    final int id = await MovieDatabase.instance.insertOrder(
      buildRecord(1001, '1 x Wildwood ticket(s)', 10.99),
    );
    expect(id, greaterThan(0));

    final List<OrderRecord> orders =
        await MovieDatabase.instance.getAllOrders();
    expect(orders.length, 1);
    expect(orders[0].id, id);
    expect(orders[0].summary, '1 x Wildwood ticket(s)');
    expect(orders[0].total, 10.99);
  });

  test('getNextOrderNumber increments the current maximum', () async {
    expect(await MovieDatabase.instance.getNextOrderNumber(), 1001);

    await MovieDatabase.instance.insertOrder(
      buildRecord(1005, 'Order', 5.0),
    );
    expect(await MovieDatabase.instance.getNextOrderNumber(), 1006);
  });

  test('getAllOrders returns newest order number first', () async {
    await MovieDatabase.instance.insertOrder(
      buildRecord(1001, 'First', 5.0),
    );
    await MovieDatabase.instance.insertOrder(
      buildRecord(1003, 'Third', 9.0),
    );
    await MovieDatabase.instance.insertOrder(
      buildRecord(1002, 'Second', 7.0),
    );

    final List<OrderRecord> orders =
        await MovieDatabase.instance.getAllOrders();
    expect(orders[0].orderNumber, 1003);
    expect(orders[1].orderNumber, 1002);
    expect(orders[2].orderNumber, 1001);
  });
}
